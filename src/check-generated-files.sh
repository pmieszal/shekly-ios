for d in */ ; do
    DIR=$d\Generated
    FILE=$d\Generated/R.generated.swift
    if [ -f "$FILE" ]; then
        echo ""
    else 
        echo "Generating FILE: $FILE"
        mkdir -p $DIR
        touch $FILE
    fi

    DIRNAME=${d%?}
    FILE=$d\/$DIRNAME+DI.swift
    if [ -f "$FILE" ]; then
        echo ""
    else 
        echo "Generating FILE: $FILE"
        touch $FILE
    fi  
done