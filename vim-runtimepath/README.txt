=========================================================================================
x Startup

    1.  Set shell/term
    2.  Command-line arguments
    3.  Process vimrc files

        a.  $HOME/.vimrc
        b.  $VIMRUNTIME/defaults.vim

    4.  Load scripts                                            Note A

        a.  :runtime! plugin/**/*.vim
        b.  :packloadall

?           i.  :runtime! START */plugin/*.vim                  Note B,C

?       c. :runtime! after/plugin/*.vim

Notes

    A. See :h load-plugins
    B. Prepends directory to runtimepath before sourcing plugin
    C. See :h packload-two-step

=========================================================================================
x Loading a file

    1.  :runtime! ftplugin/{filetype}.vim
    2.  :runtime  after/ftplugin/{filetype}.vim
    3.  :runtime! indent/{filetype}.vim
    4.  :runtime  after/indent/{filetype}.vim
    5.  :runtime! syntax/{filetype}.vim
    6.  :runtime  after/syntax/{filetype}.vim

=========================================================================================
x Scripts

    ACTION                                                  TRIGGERED BY

    :source      $HOME/.vimrc                               Startup 1
    :source      $VIMRUNTIME/colors/lists/default.vim       :colorscheme {name}
    :runtime     {name}.vim
    :runtime!    filetype.vim                               :filetype on
    :source      $VIMRUNTIME/filetype.vim                   :filetype on
    :runtime!    ftdetect/*.vim
    :runtime     ftplugin.vim                               :filetype plugin on
    :runtime     indent.vim                                 :filetype indent on
    :runtime!    plugin/**/*.vim                            Startup 4.a
    :packloadall                                            Startup 4.b


TODO

    : syntax-loading

=========================================================================================
x Runtime Path

    filetype.vim    filetypes by file name          |new-filetype|
    scripts.vim     filetypes by file contents      |new-filetype-scripts|
    autoload/       automatically loaded scripts    |autoload-functions|
    colors/         color scheme files              |:colorscheme|
    compiler/       compiler files |:compiler|
    doc/            documentation |write-local-help|
    ftplugin/       filetype plugins |write-filetype-plugin|
    import/         files that are found by `:import`
    indent/         indent scripts |indent-expression|
    keymap/         key mapping files |mbyte-keymap|
    lang/           menu translations |:menutrans|
    menu.vim        GUI menus |menu.vim|
    pack/           packages |:packadd|
    plugin/         plugin scripts |write-plugin|
    print/          files for printing |postscript-print-encoding|
    spell/          spell checking files |spell|
    syntax/         syntax files |mysyntaxfile|
    tutor/          files for vimtutor |tutor|

=========================================================================================
Notes:

main(...)

    common_init(mparm_T*)

        init_locale()  // locale set
        gui_prepare()  // GUI prepared
        clip_init()  // clipboard checked
        set_init_1()  // inits 1

    command_line_scan(mparm_T*)  // parsing arguments

    mch_init()  // shell init

    screen_start()  // Termcap init

    set_init_2()  // inits 2

    init_highlight()  // init highlight

    exe_pre_commands()

    source_startup_scripts()  // sourcing vimrc file(s)

        do_source(...)  // scriptfile.c
