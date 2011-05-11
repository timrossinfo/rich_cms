require File.expand_path("../../../test_helper.rb"            , __FILE__)
require File.expand_path("../rendering_test/helper_methods.rb", __FILE__)

require "hpricot"

module Content
  class RenderingTest < ActiveSupport::TestCase

    include HelperMethods

    context "A Rich-CMS content class" do
      context "using the memory store engine" do

        setup do
          Rich::Cms::Content.classes.reject!{|klass| !%w(Foo Bar Translation).include? klass.name}

          class Foo
            include Rich::Cms::Content
            storage :memory
            configure :as => :html
          end
          class Bar
            include Rich::Cms::Content
            storage   :memory
            configure "bar_content", :tag => :h1
          end
          forge_rich_i18n

          @javascript_hashes = ActiveSupport::OrderedHash.new
          @javascript_hashes[Bar        ] = %Q({keys: ["data-store_key"], value: "data-store_value"})
          @javascript_hashes[Translation] = %Q({keys: ["data-store_key"], value: "data-store_value", beforeEdit: Rich.I18n.beforeEdit, afterUpdate: Rich.I18n.afterUpdate})
          @javascript_hashes[Foo        ] = %Q({keys: ["data-store_key"], value: "data-store_value"})
        end

        should "be configurable" do
          assert_equal "rcms_foo"     , Foo.css_class
          assert_equal "bar_content"  , Bar.css_class
          assert_equal({:as  => :html}, Foo.configuration)
          assert_equal({:tag => :h1  }, Bar.configuration)

          assert_expectation({}, %q{
                             <h1 class="bar_content" data-store_key="some_key" data-store_value="">
                               < some key >
                             </h1>},
                             Bar.new(:key => "some_key"))

          assert_expectation({:tag => :none}, %q{
                             <span class="bar_content" data-store_key="some_key" data-store_value="">
                               < some key >
                             </span>},
                             Bar.new(:key => "some_key"))

          Rich::Cms::Auth.expects(:login_required?).at_least_once.returns true
          Rich::Cms::Auth.expects(:admin).at_least_once.returns nil

          assert_expectation({}, %q{
                             <h1>
                               some key
                             </h1>},
                             Bar.new(:key => "some_key"))

          assert_expectation({:tag => :none}, %q{
                             some key},
                             Bar.new(:key => "some_key"))
        end

        should "return the expected javascript hash (per CMS content class)" do
          assert_equal @javascript_hashes[Foo        ], Foo.to_javascript_hash
          assert_equal @javascript_hashes[Bar        ], Bar.to_javascript_hash
          assert_equal @javascript_hashes[Translation], Translation.to_javascript_hash
        end

        should "return the expected CSS class" do
          assert_equal "bar_content", Bar.css_class
          assert_equal "rcms_foo"   , Foo.css_class
          assert_equal "i18n"       , Translation.css_class
        end

        should "return the expected javascript hash (for all CMS content classes)" do
          expected = @javascript_hashes.collect{|klass, value| "#{klass.css_class.inspect}: #{value}"}.join ", "
          assert_equal "{#{expected}}", Rich::Cms::Content.javascript_hash
        end

        should "return the expected hash for the JSON response" do
          class ContentA
            include Rich::Cms::Content
            storage :memory
          end
          class ContentB
            include Rich::Cms::Content
            storage :memory
            configure "content_b"

            def to_rich_cms_response(params)
              {:timestamp => "1982-08-01 13:37:04", :__css_class__ => "foo_bar"}
            end
          end
          forge_rich_i18n

          assert_equal({:__css_class__   => "rcms_content_a",
                        :__identifier__  => {:store_key => "some_key"},
                        :store_value     => "some key"},
                       ContentA.new(:key => "some_key").to_json)

          assert_equal({:__css_class__   => "content_b",
                        :__identifier__  => {:store_key => "some_key"},
                        :store_value     => "some key", :timestamp => "1982-08-01 13:37:04"},
                       ContentB.new(:key => "some_key").to_json)

          assert_equal({:__css_class__  => "i18n",
                        :__identifier__ => {:store_key => "nl:some_key"},
                        :store_value    => "some key",
                        :translations   => {"nl:some_key" => "some key"}},
                       Translation.new(:key => "some_key", :locale => "nl").to_json)
        end

        context "when rendering to tag" do
          setup do
            class Content
              include Rich::Cms::Content
              storage :memory
              configure "rich_cms_content"
            end
            forge_rich_i18n

            @content     = Content    .new :key => "hello_world"
            @translation = Translation.new :key => "hello_world", :locale => "nl"

            Content    .send(:content_store).clear
            Translation.send(:content_store).clear
          end

          should "be able to render Mustache" do
            @mustache_content = Content.new(:key => "mustache1")
            @mustache_content.value = "Hi, {{name}}!"
            @mustache_content.save

            assert_equal "Hi, Vicky!", Hpricot(@mustache_content.to_tag(:locals => {:name => "Vicky"})).children[0].html
            assert_equal({"class"            => "rich_cms_content",
                          "data-store_key"   => "mustache1",
                          "data-store_value" => "Hi, {{name}}!"},
                         Hpricot(@mustache_content.to_tag(:locals => {:name => "Vicky"})).children[0].raw_attributes)
          end

          context "when no login required" do
            setup do
              Rich::Cms::Auth.expects(:login_required?).at_least_once.returns false
            end

            should "render meta data" do
              assert_all     content_expectations_with_meta_data, @content
              assert_all translation_expectations_with_meta_data, @translation

              stored_content, stored_translation = update_and_fetch_contents @content, @translation

              assert_all     stored_content_expectations_with_meta_data, stored_content
              assert_all stored_translation_expectations_with_meta_data, stored_translation
            end
          end

          context "when requiring login" do
            setup do
              class User
                def can_edit?(content)
                  true
                end
              end
              Rich::Cms::Auth.expects(:login_required?).at_least_once.returns true
            end

            should "not render meta data when not being logged in" do
              Rich::Cms::Auth.expects(:admin).at_least_once.returns nil

              assert_all     content_expectations_without_meta_data, @content
              assert_all translation_expectations_without_meta_data, @translation

              stored_content, stored_translation = update_and_fetch_contents @content, @translation

              assert_all     content_expectations_without_meta_data, stored_content
              assert_all translation_expectations_without_meta_data, stored_translation
            end

            should "render meta data when allowed" do
              Rich::Cms::Auth.expects(:admin).at_least_once.returns User.new

              assert_all     content_expectations_with_meta_data, @content
              assert_all translation_expectations_with_meta_data, @translation

              stored_content, stored_translation = update_and_fetch_contents @content, @translation

              assert_all     stored_content_expectations_with_meta_data, stored_content
              assert_all stored_translation_expectations_with_meta_data, stored_translation
            end

            should "not render meta data when restricted" do
              user = User.new
              user.expects(:can_edit?).at_least_once.returns false
              Rich::Cms::Auth.expects(:admin).at_least_once.returns user

              assert_all     content_expectations_without_meta_data, @content
              assert_all translation_expectations_without_meta_data, @translation

              stored_content, stored_translation = update_and_fetch_contents @content, @translation

              assert_all     content_expectations_without_meta_data, stored_content
              assert_all translation_expectations_without_meta_data, stored_translation
            end
          end
        end

      end
    end

  end
end