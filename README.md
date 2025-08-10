# Webr-adm-ext Extension For Quarto

This extension opens a given block depending on the outcome
of an exercise.

## Installing

```bash
quarto add advdatamgmt/webr-adm-ext
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Example

Opens the solution block after the exercise is passed.

```{adm}
#| exercise: e6
#| type: open-solution-on-pass
```

Opens the rendered text in the block after the exercise is passed.

```{adm}
#| exercise: e9
#| type: open-on-pass
It seems you figured out that the `%%`{.r} operator finds the remainder of
dividing one number by another! This function is also called the modulo
operator.  Where in daily life do you use this operator relatively frequently
and probably without much thought? Any ideas?
```
