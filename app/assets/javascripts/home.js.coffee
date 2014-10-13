# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$ ->
  if $('.editor-panel').length > 0
    Live.LaunchEditorMode()
  else if $('.presentation-panel').length > 0
    Live.LaunchPresentationMode()

