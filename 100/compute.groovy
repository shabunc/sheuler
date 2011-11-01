#!/usr/bin/env groovy

def problem100 = {
    min ->
    def found = [:]
    def j = 1
    while (true) {
        def sq = j * j
        a = (j + 1) / 2
        if ((sq - 1) % 4 == 0) {
            k = (sq - 1) / 4
            found[k] = a
            if (found[k / 2]) {
                print "${a} \n"
            }
        }
        j = j + 1
    }
}

problem100(100)
    
