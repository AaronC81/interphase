# Interphase - a powerful, easy-to-use, native-looking GUI library for Ruby
[![Build Status](https://travis-ci.org/OrangeFlash81/Interphase.svg?branch=master)](https://travis-ci.org/OrangeFlash81/Interphase)

![Logo](img/logo_small.png)

### Have a feature request? Need some help? Want to get involved? [Join our Discord!](https://discord.gg/XjMjKzC)

## What is Interphase?
Interphase is a **GUI library for Ruby.** It's got plenty of features & great
cross-platform support, and it's **really easy to use**.

Check out this 'Hello, world' example:

```ruby
require 'interphase'
include Interphase

window = Window.new('Hello world window') do
  size 200, 200
  quit_on_delete!

  add Label.new('Hello, world!')
end

window.show_all
window.run
```

## Quick start
First, install the Interphase gem:

```
gem install interphase
```

In the future, Interphase will have tutorials, but for now, check out the
[documentation](http://www.rubydoc.info/github/OrangeFlash81/Interphase/).

## More info

Interphase is effectively a 'friendly wrapper' for GTK2, so it supports a
plethora of widgets which look great on any platform.

Threading isn't an issue either; one simple `in_background` call creates a 
`Thread` and binds it to a window, killing the thread when the window is closed.

```ruby
window = Window.new do
  in_background do
    # A long-running task
  end
end
```

Interphase also uses a novel widget naming system based on keyword arguments.
Every widget may be assigned a `name:` keyword argument in its constructor.
It is bound by this name to its container, through which it may be referenced
later. 

```ruby
window = Window.new do
  add Label.new('Hello', name: 'my_label')
end

window.my_label.text = 'Hello again'
```

Events (called 'signals' in GTK) can be handled using the `on` method, which
registers a block to run when a signal occurs. The signals in Interphase are the
same as those in GTK2. Some important signals, such as `delete-event` for a
`Window`, also have their own `on_...` methods.

```ruby
# These are equivalent
window.on('delete-event') do
  quit
end

window.on_delete do
  quit
end
```

## How does it work?
Interphase components, formerly 'widgets', derive from the `Widget` class. Each
instance maintains an instance variable named `@gtk_instance`, which is what
is *actually* rendered. Most of the methods on `Widget` subclasses actually
mutate the underlying `@gtk_instance`.

Widgets accept a block in their constructor which is evaluated on the new widget.
In practice, this means that the following two code snippets are equivalent;
the second style is encouraged over the first:

```ruby
window = Window.new
window.size(800, 600)
window.add(Label.new('Hello'))
```

```ruby
window = Window.new do
  size 800, 600
  add Label.new('Hello')
end
```

## Why GTK2?
There are plenty of GUI frameworks already, but Interphase is based on GTK2 for
a variety of reasons:

  - **Easy to set up.** On most systems, the whole GTK2 framework can be
    installed using `gem`. I aimed for no fiddling around with DLLs or
    installers, ruling out Qt.
  - **Looks native out of the box.** The user or developer doesn't need to
    apply a theme to every window for it to look OS-native. Manual theming is
    required in GTK3, making it unsuitable for Interphase.
  - **Actively supported in Ruby.** wxWidgets is fantastic, and would've been
    ideal for this project, but its Ruby gem is unmaintained.
  - **Powerful.** Plenty of widgets are already implemented, and can be 
    expanded upon easily. This is where Tk fell short.

## Why not just use the `gtk2` gem directly?
  - **Slightly archaic API**. The API feels like a direct C++ port, and as such
    isn't very Ruby-like.
  - **Overcomplicated data structures**. Creating a list box in GTK2 involves
    creating a special `ListStore` instance and inserting items into it using
    pointer objects. Interphase does all of this for you by monitoring changes
    to a simple `Array` of items instead.
  - **Lack of high-quality tutorials**. Interphase's official documentation
    will *eventually* have plenty of tutorials for both beginners and advanced
    users.  

## Where does Interphase fall short?
Nothing's perfect!

  - **It's easy, but not the easiest.** Interphase aims to steer clear of the
    DSL-esque nature of some other GUI libraries, such as Shoes. While this may
    make Interphase not the simplest GUI library, it can make the API feel much
    more robust.
  - **It's new.** It's untested. It doesn't have much documentation *yet*.
    Compared to the 'big ones' like Qt, Interphase has very little recognition,
    and as such you may find it difficult to get help on sites like Stack
    Overflow if you run into problems. Feel free to ask on our Discord though -
    see the top of the page.

## Roadmap

- **✓** Labels
- **✓** Fixed containers
- **✓** Box containers
- Grid containers
- **✓** Buttons
- Form controls (e.g. dropdowns, input boxes, date pickers)
- Toolbars and tool button strips
- Menus
- Images
- **✓** Text dialog boxes
- Input dialog boxes
- Other dialog boxes (e.g. file chooser, print)
- **✓** List views
- Tree views
- **✓** Status bars
- Tab views
- Custom `on_...` events for all common signals
- *Pages* - easily interchangable window contents
- Easy implementation of custom controls