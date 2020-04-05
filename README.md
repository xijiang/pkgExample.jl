# pkgExample.jl
A test julia package repo to demonstrate how to create a publicly shared package.

## Create a public julia package

Here the package is named `pkgExample`.  You can name your package whatever else.

### Start a Julia project with its REPL

```julia
]
generate pkgExample
```

A a directory `pkgExample` whill be create at `pwd`.

which has
- Project.toml
- src
  - `pkgExample.jl`

### Prepare a public package repo

Here I use `GitHub` for example.

If you are not `GitHub` ready, do the follows:
- Create an account on [GitHub](https://github.com).
- Setup ssh key pair so that you can use `git` command line.
- You may also want to configure you local `git`.

Create a package called `pkgExample.jl`. On my `GitHub`, this is at https://github.com/xijiang/pkgExample.jl. I added 
- some descriptions. These will be in the `README.md` file.
- a README.md file
- an `MIT` license
- a `.gitignore` for julia development

### Local configurations
```bash
cd $(pwd)/pkgExample
git init
git add Project.toml src/pkgExample.jl
git remote add origin git@github.com:xijiang/pkgExample.jl
git pull origin master
```

The last command will merge the remote, named `origin`, which has three files:
- .gitignore
- LICENSE
- README.md

with the local, i.e., master.

This package is now ready for future development.

It is also publicly available. 

The `MIT` license is very convenient. It states that the package is mine. Anybody else can use it. But all of their own risks. Now:

```bash
git commit -am 'starting point'
git push origin master
```

This package is now ready for others to use.

## Appendix - an example git configuration
Change according to your own convenience.

```bash
sudo yum install git meld	# if not installed
git config --global user.name "Xijiang Yu"
git config --global user.email xijiang@users.noreply.github.com
# git commit --amend --reset-author
git config --global core.editor emacs # if you like Emacs more, default vi
git config --global merge.tool meld
git config --global alias.ss 'status -s'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
# git config --global color.ui true  # for CentOS version
# for nbdime
pip install --user --upgrade nbdime
jupyter-serverextension enable --py nbdime --user
nbdime config-git --enable --global
git config --list  # to see the current configurations
```

In the previous section, we created a package called `pkgExample`. After a `pull` request to `GitHub`, it contains below:

- LICENSE
- Project.toml
- README.md
- src # a directory
  - `pkgExample.jl`

`pkgExample.jl` has the following content:
```julia
module pkgExample

greet() = print("Hello World!")

end # module
```

In this section, we will add some functions to this package.

## Hello world!
### Commit and push

### Add the package to your Julia environment
```julia
]
add "https://github.com/xijiang/pkgExample.jl"

# then `backspace` to REPL

import pkgExample

pkgExample.greet()
```

You will see `Hello World!` printed as the function result.

I want to add here is that the package name `pkgExample` must be specified to run the `greet` function. If you want to run `greet` without the package name, `export greet` should be inserted into `pkgExample.jl`. This is usually not a good practice though.

### Add a function

We add a one-line `plusone` function into the package. Now `pkgExample.jl` looks like this:

```julia
module pkgExample

export plusone

greet() = print("Hello World!")

plusone(x::Int) = x + 1

end # module
```

Now in the package directory:
```bash
git commit -am 'plusone function'
git push origin master
```

It is easier that you quit current REPL and back in again:
```julia
]
update pkgExample

# backspace to REPL
using pkgExample

plusone(12)
```

### Add more functions
Gradually, more and more functions will be added to the package you are developing. And you might put functions in separate files.

Here, we create another function `sumRand`, which is stored in `sumRand.jl`:
```julia
sumRand(n::Int = 10) = sum(rand(n))
```

We then append one line:
```julia
include("sumRand.jl")
```

at the end of `pkdExample.jl`

In the package directory:
```bash
git add src/sumRand.jl
git commit -am 'more functions'
git push origin master
```

We then repeat the `exit REPL` $\rightarrow$ `re-enter REPL` $\rightarrow$ `update pkgExample` $\rightarrow$ `using pkgExample` cycle. I will call this cycle `update`.

Since `sumRand` was not exported, we need to run `pkgExample.sumRand()`.

### Add tests
It is a good practice to add some test procedure to ensure your package more correct. In the package directory, run julia:

```julia
]
activate .
add Test
```
This will add dependant `Test` to the project. 

Create `test/runtests.jl` as below:
```julia
println("Testing pkgExample ...")

using Test, pkgExample
@test pkgExample.plusone(17) == 18
```

`add test/runtests.jl`, then `commit` and `push` the package.

Run a separate `julia` REPL:
```julia
]
update pkgExample
test pkgExample
```

The only test should have a pass.
