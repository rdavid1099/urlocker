var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#filters').on('click', 'button.filter-read', function(){
    showLinks('read')
  })

  $('#filters').on('click', 'button.filter-unread', function(){
    showLinks('unread')
  })

  function showLinks (filter) {
    var hey = $.ajax({
      type: 'GET',
      url: '/api/v1/links',
      data: { get_param: 'value' },
      dataType: 'json',
      success: function (data) {
        clearLinksList()
        $.each(data, function (index, link) {
          if (filter === 'read') {
            if (link.read === true) {
              renderReadLink(link)
            }
          } else if (filter === 'unread') {
            if (link.read === false) {
              renderUnreadLink(link)
            }
          }
        })
      }
    });
  }

  function renderReadLink(link){
    $("#links-list").append(
      `<div class='link clicked' data-id='${link.id}' id="link-${link.id}">
        <p class='link-title'>${ link.title }</p>
        <p class='link-url'>${ link.url }</p>

        <p class="link_read">
          Read? ${ link.read }
        </p>
        <p class="link_buttons">
          <button class="mark-read">Mark as Unread</button>
          <a href='/links/${link.id}/edit'><button class='edit-link'>Edit</button></a>
          <a data-confirm='Are you sure you want to delete this link?' data-method='delete' href='/links/${link.id}'><button class='delete-link'>Delete</button></a>
        </p>
      </div>`
    )
  }

  function renderUnreadLink(link){
    $("#links-list").append(
      `<div class='link' data-id='${link.id}' id="link-${link.id}">
        <p class='link-title'>${ link.title }</p>
        <p class='link-url'>${ link.url }</p>

        <p class="link_read">
          Read? ${ link.read }
        </p>
        <p class="link_buttons">
          <button class="mark-read">Mark as Read</button>
          <a href='/links/${link.id}/edit'><button class='edit-link'>Edit</button></a>
          <a data-confirm='Are you sure you want to delete this link?' data-method='delete' href='/links/${link.id}'><button class='delete-link'>Delete</button></a>
        </p>
      </div>`
    )
  }

  function clearLinksList () {
    $("#links-list").text('')
  }

})
