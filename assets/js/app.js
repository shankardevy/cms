// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import topbar from "topbar"
import {LiveSocket} from "phoenix_live_view"
import "alpinejs"

// Phoenix LiveView Hooks
let Hooks = {}
Hooks.QuillEditor = {
  initEditor(elem) {
    var quill = new Quill(elem, {
      formats: ['bold', 'italic', 'link', 'list'],
      modules: {
        toolbar: [
          ['bold', 'italic'],
          [{ list: 'ordered' }, { list: 'bullet' }],
          ['link', 'image']
        ],
        clipboard: {
          matchVisual: false // https://quilljs.com/docs/modules/clipboard/#matchvisual
        }
      },
      placeholder: 'Write a comment...',
      theme: 'snow'
    });

    // Store accumulated changes
    quill.on('text-change', function() {
      elem.nextElementSibling.value = quill.root.innerHTML;
    });
  },
  mounted() {
    var editor = this.el.getElementsByClassName("quill-editor")[0]
    this.initEditor(editor)
  },
  updated() {
    var editor = this.el.getElementsByClassName("quill-editor")[0]
    this.initEditor(editor)
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

let liveSocket = new LiveSocket('/live', Socket, {
  dom: {
    onBeforeElUpdated(from, to){
      if(from.__x){ Alpine.clone(from.__x, to) }
    }
  },
  params: {
    _csrf_token: csrfToken
  },
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("petal:page-loading-start", info => topbar.show())
window.addEventListener("petal:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
