{:plugins [[lein-ancient "0.6.14"]
           [jonase/eastwood "0.2.4"]    ; clojure linter
           ]}
{:eastwood {:namespaces [:source-paths]
            :add-linters [:unused-namespaces]}}
