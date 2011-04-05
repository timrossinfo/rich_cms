# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rich_cms}
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Engel"]
  s.date = %q{2011-04-05}
  s.description = %q{Rich-CMS is a module of E9s (http://github.com/archan937/e9s) which provides a frontend for your CMS content. You can use this gem to manage CMS content or translations (in an internationalized application). The installation and setup process is very easily done. You will have to register content at the Rich-CMS engine and also you will have to specify the authentication mechanism. Both are one-liners.}
  s.email = %q{paul.engel@holder.nl}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "CHANGELOG.rdoc",
    "MIT-LICENSE",
    "README.textile",
    "Rakefile",
    "VERSION",
    "app/controllers/rich/cms_controller.rb",
    "app/controllers/rich/cms_sessions_controller.rb",
    "app/views/rich/cms/_dock.html.erb",
    "app/views/rich/cms/dock/_menu.html.erb",
    "app/views/rich/cms/dock/_panel.html.erb",
    "app/views/rich/cms/dock/panel/_edit.html.erb",
    "app/views/rich/cms/dock/panel/_login.html.erb",
    "app/views/rich/cms/dock/panel/edit/_rails2.html.erb",
    "app/views/rich/cms/dock/panel/edit/_rails3.html.erb",
    "app/views/rich/cms/dock/panel/login/_rails2.html.erb",
    "app/views/rich/cms/dock/panel/login/_rails3.html.erb",
    "app/views/rich_cms.html.erb",
    "assets/images/cleditor/buttons.gif",
    "assets/images/cleditor/toolbar.gif",
    "assets/jzip/jquery/cleditor.js",
    "assets/jzip/jquery/core.jz",
    "assets/jzip/jquery/extensions/ajaxify.js",
    "assets/jzip/jquery/extensions/browser_detect.js",
    "assets/jzip/jquery/extensions/modules.js",
    "assets/jzip/jquery/extensions/object.js",
    "assets/jzip/jquery/raccoon_tip.js",
    "assets/jzip/jquery/ui/components/core.js",
    "assets/jzip/jquery/ui/components/draggable.js",
    "assets/jzip/jquery/ui/components/mouse.js",
    "assets/jzip/jquery/ui/components/widget.js",
    "assets/jzip/jquery/ui/rich_cms/core.jz",
    "assets/jzip/jquery/ui/rich_cms/draggable.jz",
    "assets/jzip/jquery/ui/rich_cms/mouse.jz",
    "assets/jzip/jquery/ui/rich_cms/widget.jz",
    "assets/jzip/native/extensions.js",
    "assets/jzip/rich.js",
    "assets/jzip/rich/cms.js",
    "assets/jzip/rich/cms/dock.js",
    "assets/jzip/rich/cms/editor.js",
    "assets/jzip/rich/cms/menu.js",
    "assets/jzip/rich_cms.jz",
    "assets/sass/rich_cms.sass",
    "assets/sass/rich_cms/_content.sass",
    "assets/sass/rich_cms/_dock.sass",
    "assets/sass/rich_cms/_menu.sass",
    "assets/sass/rich_cms/_panel.sass",
    "assets/sass/rich_cms/_reset.sass",
    "assets/sass/tools/_css3.sass",
    "assets/sass/tools/_mixins.sass",
    "config/routes.rb",
    "lib/generators/rich/cms_admin/cms_admin_generator.rb",
    "lib/generators/rich/cms_admin/templates/authlogic/migration.rb",
    "lib/generators/rich/cms_admin/templates/authlogic/model.rb",
    "lib/generators/rich/cms_admin/templates/authlogic/session.rb",
    "lib/generators/rich/cms_content/cms_content_generator.rb",
    "lib/generators/rich/cms_content/templates/migration.rb",
    "lib/generators/rich_cms.rb",
    "lib/rich/cms/actionpack.rb",
    "lib/rich/cms/actionpack/action_controller/base.rb",
    "lib/rich/cms/actionpack/action_view/base.rb",
    "lib/rich/cms/auth.rb",
    "lib/rich/cms/engine.rb",
    "lib/rich/cms/version.rb",
    "lib/rich_cms.rb",
    "rails_generators/rich_cms_admin/lib/devise/route_devise.rb",
    "rails_generators/rich_cms_admin/rich_cms_admin_generator.rb",
    "rails_generators/rich_cms_admin/templates/authlogic/migration.rb",
    "rails_generators/rich_cms_admin/templates/authlogic/model.rb",
    "rails_generators/rich_cms_admin/templates/authlogic/session.rb",
    "rails_generators/rich_cms_admin/templates/config.rb",
    "rails_generators/rich_cms_admin/templates/devise/README",
    "rails_generators/rich_cms_admin/templates/devise/devise.rb",
    "rails_generators/rich_cms_admin/templates/devise/en.yml",
    "rails_generators/rich_cms_admin/templates/devise/migration.rb",
    "rails_generators/rich_cms_admin/templates/devise/model.rb",
    "rails_generators/rich_cms_content/rich_cms_content_generator.rb",
    "rails_generators/rich_cms_content/templates/config.rb",
    "rails_generators/rich_cms_content/templates/migration.rb",
    "rails_generators/rich_cms_content/templates/model.rb",
    "rich_cms.gemspec"
  ]
  s.homepage = %q{http://codehero.es/rails_gems_plugins/rich_cms}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Enrichments (e9s) module for a pluggable CMS frontend}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, ["~> 3.0.25"])
      s.add_runtime_dependency(%q<jzip>, ["~> 1.0.11"])
    else
      s.add_dependency(%q<haml>, ["~> 3.0.25"])
      s.add_dependency(%q<jzip>, ["~> 1.0.11"])
    end
  else
    s.add_dependency(%q<haml>, ["~> 3.0.25"])
    s.add_dependency(%q<jzip>, ["~> 1.0.11"])
  end
end

