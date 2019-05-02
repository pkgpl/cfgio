# CFGIO
Fortran config file parser

## Install
```sh
make
make install
```

## Compile
```
your_fortran_compiler -o main.e main.f90 -I/path/to/include -L/path/to/lib -lcfgio
```

## Config (ini) file
A [configuration file](https://en.wikipedia.org/wiki/Configuration_file) contains sections, keywords, and values as follows.

```
[Section title]
keyword = value
```

Lines starting with `#` or `;` are comments.

Here is an example configuration file.

```
[DEFAULTS]
path = ../include
use_abs = True

[Section 1]
nmax = 30
# comment 1
vmin = 1.0
freqs = 5.0, 10.0, 30.0, 50.0
amps = 0.0, 1.0, 1.0, 0.0
path = ../text

[Section 2]
use_abs = no
; comment 2
my file = ${Section 1:path}/file.txt
```

Let's parse it using Fortran.


## cfgio_mod module

### cfg_t type
A derived data type `cfg_t` is required to parse a config file.

```fortran
use cfgio_mod, only: cfg_t, parse_cfg
type(cfg_t):: cfg
```

### Input
We can use `cfg = parse_cfg(config_file_name)` to parse a config file. The resultant `cfg_t` type varable `cfg` contains all sections, keys and values of the config file. Use `call cfg%get(section_title,keyword,value)` to get a value from the derived data type. `value` can be one of following types.

- `integer`
- `logical`
- `character(len=*)`
- `real(kind=4)`
- `real(kind=8)`
- `complex(kind=4)`
- `complex(kind=8)`
- allocatable arrays of above types for array input/output

For example, we can parse the example config file using the following code.

```fortran
use cfgio_mod
type(cfg_t):: cfg
integer:: nmax, npar
real:: vmin
real(kind=8),allocatable:: freqs(:),amps(:)
logical:: flag1,flag2
character(len=256):: filename

cfg=parse_cfg("test.cfg")
call cfg%get("Section 1","nmax",nmax)    !! 30
call cfg%get("Section 1","vmin",vmin)    !! 1.0

call cfg%get("Section 1","freqs",freqs)  !! [5.0, 10.0, 30.0, 50.0]
call cfg%get("Section 1","amps",amps,npar)  !! [0.0, 1.0, 1.0, 0.0], npar=4
call cfg%get("Section 1","use_abs",flag1) !! .true. (from DEFAULTS section)

call cfg%get("Section 2","use_abs",flag2) !! .false.
call cfg%get("Section 2","my file",filename) !! ../text/file.txt (interpolated)
```

The code may require additional explanations regarding "DEFAULTS" section, array input, string interpolation, and boolean values.

#### DEFAULTS section
If a keyword is missing in the designated section, `cfgio` tries to search the keyword from the 'DEFAULTS' section (Idea from [Python configparser](https://docs.python.org/3/library/configparser.html)). For example, `flag1` value from the above code is from the 'DEFAULTS' section because "Section 1" does not contain "use_abs" keyword.

#### Array input
We can use allocatable arrays to obtain a list of values. `cfg.get` subroutine allocates the memory. Optionally, the subroutine returns number of parameters in a list as shown in the example using `npar`. 

#### Interpolation
`${key1}` in a value is replaced with the value of `key1` in the current section. We can specify the section name containing the keyword as `${Section 1:key1}` as shown in the example (`filename`). "DEFAULTS" section for a missing keyword is also available in the interpolation process.

#### Boolean
Following strings are rendered as `.true.`. Otherwize, `.false.`

- TRUE, True, true, T, t
- YES, Yes, yes, Y, y
- ON, On, on
- .TRUE., .true.


### Output

We can assign a `key=value` pair to a `cfg_t` type variable using `call cfg%set(section_title,keyword,value)` and write a config file using `call cfg.write(output_file_name)`. We can use a logical unit number instead of the `output_file_name`. If the `output_file_name` argument is missing, the subroutine writes output to the standard output.

```fortran
use cfgio_mod
type(cfg_t):: cfg
integer:: value=1
real:: values(3) = [1.0,2.0,3.0]

call cfg%set("Section 1","value",value)
call cfg%set("Section 2","values",values)
call cfg%write("output.cfg")
```

### API reference
```fortran
type(cfg_t):: cfg
integer:: value
! Supported types of input/output values:
!   integer, logical, character(len=*),
!   real(kind=4), real(kind=8),
!   complex(kind=4), complex(kind=8),
!   allocatable arrays of above types

!!! INPUT
!! parse config file
cfg=parse_cfg("config_file_name")

!! getter subroutines
! The program stops if it cannot find the "key" in both "section title" and "DEFAULTS" sections.
call cfg%get("section title","key",value)

! (optional integer output) npar: number of parameters (array size)
call cfg%get("section title","key",value,npar)

!! getter functions
val = cfg%gets("section title","key") ! character
val = cfg%getb("section title","key") ! logical
val = cfg%geti("section title","key") ! integer
val = cfg%getf("section title","key") ! real(kind=4)
val = cfg%getd("section title","key") ! real(kind=8)
val = cfg%getc("section title","key") ! complex(kind=4)
val = cfg%getz("section title","key") ! complex(kind=8)

!! Does the file have designated section/keyword?
if( .not. cfg%has_section("section title") ) stop

if( .not. cfg%has_key("section title","key") ) stop

! search_defaults=.false. : Do not try to find the key in the DEFAULTS section
if( .not. cfg%has_key("section title","key",search_defaults=.false.) ) stop


!!! OUTPUT
call cfg%set("section title","key",value)

!! generate a config file (we can use 'print' instead of 'write')
call cfg%write("output_file_name.cfg")

! to standard output
call cfg%write()

open(output_unit_number,file="output_file_name.cfg")
call cfg%write(output_unit_number)
close(output_unit_number)

```
