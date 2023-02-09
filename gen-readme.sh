for CHART in ./charts/*; do 
    if [ -d "$CHART" ]; then
        printf '%*s\n' 128 | tr ' ' -
        echo " Charts to be processed:"
        printf '%*s\n' 128 | tr ' ' -
        echo " $(basename $CHART)"
        printf '%*s\n' 128 | tr ' ' -
        readme-generator -v ${CHART}/values.yaml -r ${CHART}/README.md;
    fi
done
