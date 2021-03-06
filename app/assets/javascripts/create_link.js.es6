var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){
  $newLinkTitle = $("#link-title");
  $newLinkUrl  = $("#link-url");

  $("#new-link").on('submit', createLink);
})

function createLink (event){
  event.preventDefault();

  clearFlash()

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .fail( displayFailure )
 }

function getLinkData() {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink(link){
  $("#links-list").append( linkHTML(link) )
  clearLink();
}

function linkHTML(link) {

    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
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
              <strong><p class='badges'>
              </p></strong>
            </div>`
}

function clearLink() {
  $newLinkTitle.val("");
  $newLinkUrl.val("");
}

function displayFailure(failureData){
  $('#link-flash').append( flashError(failureData.responseText) )
}

function flashError(failureData) {
  return `<div class='alert alert-error'>
            ${failureData}
          </div>`
}

function clearFlash () {
  $('#link-flash').text('')
}
