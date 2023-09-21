function _puffer_fish_expand_dots -d 'expand ... to ../.. etc'
    set -l cmd (commandline --cut-at-cursor)
    set -l split (string split ' ' $cmd)

    # Probably needs proper implementation with a dedicated global var and a repo fork
    # Example: cd. -> cd ..
    set -l catch_commands cd cp mv
    if contains $cmd $catch_commands
        commandline --replace "$cmd .."
        return 0
    end

    switch $split[-1]
        case './*'; commandline --insert '.'
        case '*..'
            # Only expand if the string consists of dots and slashes.
            # We don't want to expand strings like `bazel build target/...`.
            if string match --quiet --regex '^[/.]*$' $split[-1]
                commandline --insert '/..'
            else
                commandline --insert '.'
            end
        case '*'; commandline --insert '.'
    end
end
