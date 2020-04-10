for d in */ ; do
    DIR=$d\Generated
    FILE=$d\Generated/R.generated.swift
    if [ -f "$FILE" ]; then
        echo ""
    else 
        echo "Generating file: $FILE"
        mkdir -p $DIR
        touch $FILE
    fi
done