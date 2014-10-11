# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

template = """
int r;
float c;

void setup () {
  size(460, 400); // don't change this
  background(0);
  noStroke();

  c = 0.0;
  w = 10;
}

void draw() {
  // your code here!
  fill(0, 10);
  rect(0, 0, width, height);

  fill(100, 0, 255);
  r = (height/2) + 100 * sin(c);
  ellipse(width/2, height/2, r, r);
  c += 0.1;
}
"""

window.dmp = new diff_match_patch()

# store users' code w/ their button
setUserCode = (uid, code) ->
  console.log("update", uid, "with", code.length, "bytes")
  $('.js-users').find("##{ uid } .js-user-code").data('code', code)
  $('.js-users').find("##{ uid } .code-size").text "#{ code.length } bytes"

$ ->
  sock = new Live.Socket('primary', SESSION_ID)

  if localStorage.getItem('code')
    Editor.setValue(localStorage.getItem('code'))

  send = ->
    code = Editor.getValue()
    artist.drawWith(code)
    sock.send code
    setUserCode(SESSION_ID, code)

  the_codes = {}

  $('.js-send').on 'click', (evt) ->
    evt.preventDefault()
    send()

  $('.js-template').on 'click', (evt) ->
    # console.log "replace with", template
    Editor.setValue(template)
    saveLocally()

  saveLocally = _.debounce(() ->
    # console.log 'store', Editor.getValue()
    localStorage.setItem('code', Editor.getValue())
  , 200)

  $('#editor').on 'keypress', (evt) ->
    if evt.charCode == 13 and evt.shiftKey
      send()
      evt.preventDefault()
    saveLocally()

  $('.js-users').on 'click', '.js-user-code', (evt) ->
    code = $(evt.target).data('code')
    if code?
      console.log('GRAP NEW CODE')
      Editor.setValue(code)
      artist.drawWith(code)

  artist = new Live.Artist(document.getElementById('js-canvas'))

  sock.onmessage (message) ->
    if message.user != 'system'
      # compute diff and patch editor content based on sent content
      text1 = Editor.getValue()
      text2 = message.comment

      # results = text2

      diff = dmp.diff_main(text1, text2, true)
      # console.log 'diff: ', diff

      if diff.length > 2
        dmp.diff_cleanupSemantic(diff)

      patch_list = dmp.patch_make(text1, text2, diff)
      # console.log 'patch_list: ', patch_list

      patch_text = dmp.patch_toText(patch_list)
      # console.log 'patch_text: ', patch_text

      results = dmp.patch_apply(patch_list, text1)
      # console.log 'results: ', results

      new_text = results[0]

      # Editor.setValue(new_text)
      # artist.drawWith(new_text)

      if message.user == SESSION_ID
        uname = "You"
      else
        uname = message.user

      $('.js-chat').prepend("
        <div>
          <strong>#{uname}</strong>: [#{Date.now()}] UPDATED CODE!
          <!-- <pre><code>#{message.comment}</code></pre> -->
        </div>
      ")

      setUserCode message.user, message.comment

      # catch ex
      #   console.error(ex)
    else
      $('.js-users').empty()

      _.each _.values(message.members), (user) ->
        console.log('connected user', user)

        $('.js-users').append("
        <div id='#{ user.id }' class='user-info'>
          <button class='btn btn-warning js-user-code'>
            #{if user.id == SESSION_ID then 'You' else user.id }
          </button>
          <span class='btn btn-link code-size' disabled='disabled'>#{user.code.length} bytes</span>
        </div>
        ")
        setUserCode user.id, user.code

      $('.js-chat').prepend("
        <div>
          <strong>#{message.user}</strong>:  [#{new Date}] #{message.comment}
        </div>
      ")
