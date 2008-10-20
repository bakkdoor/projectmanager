module AjaxHelper
  def edit_form_container_for(object, prefix = "add")
    "<div id='#{prefix}_#{object}_div' style='display:none'></div>
    #{cancel_link_for(object, prefix)}"
  end
  
  def cancel_link_for(object, prefix = "add")
    "<div id='cancel_#{prefix}_#{object}_link' style='display:none'>
      #{icon_tag 'cancel'}
      #{link_to_function 'Abbrechen' do |page| 
                  page.visual_effect :fade, "cancel_#{prefix}_#{object}_link"
                  page.visual_effect :fade, "#{prefix}_#{object}_div"
                  page.visual_effect :appear, "#{prefix}_#{object}_link"
                end}
    <br/></div>"
  end
  
  def rjs_for_edit_form_for(page, object, prefix = "add")
    page["#{prefix}_#{object}_div"].replace_html :partial => "edit_form", :object => instance_variable_get("@#{object}")
    page["#{prefix}_#{object}_link"].hide
    page.visual_effect :appear, "#{prefix}_#{object}_div"
    page.visual_effect :appear, "cancel_#{prefix}_#{object}_link"
  end
  
  def rjs_for_destroy_for(page, object)
    page.visual_effect :fade, "#{object}_#{instance_variable_get("@#{object}").id}"
    page[:flash_notice].replace_html flash[:notice]
    page.visual_effect :highlight, :flash_notice
    flash.discard
  end
end