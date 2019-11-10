# Getting OS-X-Command+x/c/v to work in terminal

On the Ubuntu desktop, the keyboard map places Ubuntu-control where OS-X-Command is. Thus you have the familiar OS-X-Command+x/c/v.

In the Ubuntu Terminal, the keyboard map places Ubuntu-hyper where OS-X-Command is. The following autokey settings give you the familiar cut/copy/paste:

OS-X: Command+x/c/v -> bind to Ubuntu: hyper+x/c/v

    keyboard.send_keys("<ctrl>+<shift>+c")

OS-X: Command+x/c/v -> bind to Ubuntu: hyper+x/c/v

    keyboard.send_keys("<ctrl>+<shift>+v")

OS-X: Command+x/c/v -> bind to Ubuntu: hyper+x/c/v

    keyboard.send_keys("<ctrl>+<shift>+x")
    
    
# Getting OS-X-Ctrl+a/e/d/k to work on the desktop

In the Ubuntu Terminal, OS-X-Ctrl+a/e/d/k works like Ubuntu-Ctrl+a/e/d/k. The keyboard map places Ubuntu-Ctrl where OS-X-Ctrl is, so you have the familiar ctrl-commands.

On the Ubuntu desktop, the keyboard map places Ubuntu-hyper where OS-X-Control. The following autokey settings give you a few of the familiar Ctrl commands.

OS-X: Ctrl+a/e/d -> bind to Ubuntu: hyper+a/e/d

    keyboard.send_key("<home>")
    
OS-X: Ctrl+a/e/d -> bind to Ubuntu: hyper+a/e/d

    keyboard.send_key("<end>")
    
OS-X: Ctrl+a/e/d -> bind to Ubuntu: hyper+a/e/d

    keyboard.send_key("<delete>")
    
    
OS-X: Ctrl+k -> bind to Ubuntu: hyper+k    

    keyboard.send_keys("<shift>+<end>")
    keyboard.send_keys("<delete>")
        
# Back and forward
In OS-X, you can use Command+[/] in Chrome to navigate backwards/fowards. The following autokey bindings restore this functionality.

Apple: Command+[ --> bind to Ubuntu: hyper+[

    keyboard.send_keys("<alt>+<left>")

Apple: Command+] -> bind to Ubuntu: hyper+]

    keyboard.send_keys("<alt>+<right>")

# Next/prev tab
In OS-X, you can use Command+[/] in Chrome to move to prev/next tab. The following autokey bindings restore this functionality.

Apple: Command+{ --> bind to Ubuntu: hyper+{    

    keyboard.send_keys("<ctrl>+<np_page_down>")
    
Apple: Command+} --> bind to Ubuntu: hyper+}

    keyboard.send_keys("<ctrl>+<np_page_up>")
    
# Full screen command

A full screen command can be bound, e.g. to Hyper+f as follows:

    keyboard.send_key("<f11>")
