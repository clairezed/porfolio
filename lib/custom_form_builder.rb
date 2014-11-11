module Custom

# FORM ERRORS ##########################################################

  module FormBuilder
   # Affiche les erreurs du formulaire
    # Paramètres possibles :
    # - show_title: boolean (true par défaut)
    # - only: <nested_attributes>
    # - except: <nested_attributes>
    def custom_form_errors(params = {})
      if (errors = self.object.errors).any?
        @template.content_tag :div, class: "error_explanation" do
          content = []
          if params[:show_title].nil? || params[:show_title] == true
            content << @template.content_tag(:strong, I18n.t(:form_errors))
          end
          content << @template.content_tag(:ul) do

            if params[:only]
              messages = errors.messages.map{|key, val|
                errors.full_messages_for(key) if key.to_s.include?("#{params[:only]}.")
              }.compact.flatten
            elsif params[:except]
              messages = errors.messages.map{|key, val|
                errors.full_messages_for(key) if !key.to_s.include?("#{params[:except]}.")
              }.compact.flatten
            else
              messages = errors.full_messages
            end

            return "" if messages.empty?

            messages.map {|msg| @template.content_tag(:li, msg)}.join.html_safe
          end

          content.join.html_safe
        end
      end
    end
  end

end

ActionView::Helpers::FormBuilder.send :include, Custom::FormBuilder