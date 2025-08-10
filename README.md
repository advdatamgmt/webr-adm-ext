# Webr-adm-ext Extension For Quarto

This extension opens a given block depending on the outcome
of an exercise.

## Installing

```bash
quarto add advdatamgmt/webr-adm-ext
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using



## Example

````{adm}
#| exercise: e1
This will open after the student passes e1.
````

````{adm}
#| exercise: e1
#| solution: true
# this will open e1's solution after the student passes e1
````