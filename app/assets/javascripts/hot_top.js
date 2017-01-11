var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){
  renderBadges()
})

function renderBadges () {
  $.ajax({
    method: "GET",
    url: "/api/v1/hot",
    dataType: "JSON",
    success: renderContent
  });
}

function renderContent (topLinks) {
  $.ajax({
    type: 'GET',
    url: '/api/v1/links',
    data: { get_param: 'value' },
    dataType: 'json',
    success: function (data) {
      applyBadges (data, topLinks)
    }
  })
}

function applyBadges (data, topLinks) {
  $.each(data, function (index, link) {
    hot(link, topLinks)
  })
  window.setTimeout(renderBadges, 5000)
}

function hot (link, topLinks) {
  $.each(topLinks, function (index, topLink) {
    if (link.title === topLink.title && index === 0) {
      markAsHot(link, 'top')
    } else if (link.title === topLink.title) {
      markAsHot(link, 'hot')
    }
  })
}

function markAsHot (link, status) {
  var linkId = link.id
  if (status === 'top') {
    $(`#link-${linkId} .badges`).text('TOP LINK!')
  } else {
    $(`#link-${linkId} .badges`).text('HOT!')
  }
}
