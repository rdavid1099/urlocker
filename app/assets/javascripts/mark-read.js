var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){

  $('#links-list').on('click', 'button.mark-read', function(){
    var $this = $(this);
    var linkId = $this.parents('.link').data('id');
    $this.parents('.link').toggleClass('clicked')

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read:  readStatus($this.text())}
    })
    .then(updateLinkView(this))
  })

  function updateLinkView(link) {
    var $this = $(link)
    var linkRead = $this.parents('p.link_buttons').siblings('p.link_read')
    linkRead.text(markAsRead(linkRead, $this))
  }

  function markAsRead (linkRead, button) {
    if (linkRead.text().includes('true')) {
      button.text('Mark as Read')
      return 'Read? false'
    } else {
      button.text('Mark as Unread')
      return 'Read? true'
    }
  }

  function updateReadButton(button) {
    if (button.text() === 'Mark as Read') {
      return 'Mark as Unread'
    } else {
      return 'Mark as Read'
    }
  }

  function readStatus(buttonText) {
    if (buttonText === 'Mark as Unread') {
      return false
    } else {
      return true
    }
  }
})
