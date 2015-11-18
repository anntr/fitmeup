module ApplicationHelper
  def bootstrap_class_for flash_type
    puts "KURWA"
    puts flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end


  def errors_for(object)
    if object.errors.any?
      content_tag(:div, class: "panel panel-danger") do
        concat(content_tag(:div, class: "panel-heading") do
                 concat(content_tag(:h4, class: "panel-title") do
                          concat "Ups, coś poszło nie tak! Sprawdź czy nie wystąpiły następujące błędy:"
                        end)
               end)
        concat(content_tag(:div, class: "panel-body") do
                 concat(content_tag(:ul, class: "list-unstyled") do
                          object.errors.full_messages.each do |msg|
                            concat content_tag(:li, msg)
                          end
                        end)
               end)
      end
    end
  end
end
