ActiveAdmin.register_page 'Dashboard' do
  require 'yaml'

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content(title: proc{ I18n.t("active_admin.dashboard") }) do
    form(id: "styles-form", action: admin_update_styles_path, method: :post) do
      input(name: 'authenticity_token', type: :hidden, value: form_authenticity_token.to_s)
      table(class: 'index_table') do
        thead do
          tr do
            %w[Variable Value].each &method(:th)
          end
        end
        tbody do
          SITE_CONFIG.each do |config_key, config_value|
            tr do
              td do
                label(config_key.titleize)
              end
              td do
                textarea(config_value.to_s, name: config_key)
              end
            end
          end
        end
      end
      button('Guardar cambios')
    end
  end

  controller do
    def update_styles
      site_config = {}
      site_config[:site] = params
      site_config[:site].delete('authenticity_token')

      SITE_CONFIG.each do |config_key, config_value|
        if site_config[:site][config_key] == 'false'
          SITE_CONFIG[config_key] = false
        elsif site_config[:site][config_key] == 'true'
          SITE_CONFIG[config_key] = true
        else
          SITE_CONFIG[config_key] = site_config[:site][config_key]
        end
      end
    end
  end
end
