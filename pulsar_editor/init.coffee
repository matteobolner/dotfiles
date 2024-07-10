
execFile = require('child_process').execFile

atom.commands.add 'atom-text-editor', 'custom:format-snakefile', ->
  editor = atom.workspace.getActiveTextEditor()
  filePath = editor.getPath()

  if !filePath
    atom.notifications.addError("No file path found.")
    return

  command = "/home/pelmo/.pyenv/shims/snakefmt"
  args = [filePath]
  execFile command, args, (error, stdout, stderr) ->
    if error
      console.error("Error:", error)
      console.error("Stderr:", stderr)
      atom.notifications.addError("Error formatting Snakefile", {detail: stderr, dismissable: true})
    else
      if stderr
        console.error("Stderr:", stderr)
        atom.notifications.addWarning("Warning during formatting", {detail: stderr, dismissable: true})
      editor.buffer.reload()
      atom.notifications.addSuccess("Snakefile formatted successfully")
