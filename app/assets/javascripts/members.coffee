$(document).on 'turbolinks:load', ->
  window.events_bind_member()

  $('body').on 'click', 'a.remove_member', (e) ->
    $.ajax '/members/'+ e.currentTarget.id,
        type: 'DELETE'
        dataType: 'json',
        data: {}
        success: (data, text, jqXHR) ->
          Materialize.toast('Membro removido', 4000, 'green')
          $('#member_' + e.currentTarget.id).remove()
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na remoção de membro', 4000, 'red')
    return false

window.valid_email = (email) ->
  /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email)


window.events_bind_member = () ->
  $(document).on 'keypress', '.field_member', (e) ->
    if e.which == 13
      email_val = e.target.form.elements.member_email.value
      name_val = e.target.form.elements.member_name.value

      if window.valid_email(email_val) && name_val != ""
        $('#' + e.target.form.id).submit()

  $('.field_member').bind 'blur', (e) ->
    email_val = e.target.form.elements.member_email.value
    name_val = e.target.form.elements.member_name.value
    if window.valid_email(email_val) && name_val != ""
      $('#' + e.target.form.id).submit()

  
  $('.edit_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'PUT'
        dataType: 'json',
        data: $("#"+e.target.id).serialize()
        success: (data, text, jqXHR) ->
          Materialize.toast('Membro atualizado', 4000, 'green')
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na hora de atualizar o membro', 4000, 'red')
    return false

  $('.new_member').on 'submit', (e) ->
    $.ajax e.target.action,
        type: 'POST'
        dataType: 'script',
        data: $(".new_member").serialize()
        error: (jqXHR, textStatus, errorThrown) ->
          Materialize.toast('Problema na hora de incluir membro', 4000, 'red')
    return false