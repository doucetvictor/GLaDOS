# Glados - Epitech Promo 2026

--------------------------------------

### Compile Glados

```
└─$ [make]
└─$ [make re]
```

--------------------------------------

### Start Glados

```
Without File:
└─$ [./glados]

With File:
└─$ [./galdos < example_test.scm]
or:
└─$ [cat example_test.scm | ./galdos]
```

--------------------------------------

### Command Lines

```
Welcome to Glados !

Commands:
  !quit - Quit the program.
  !man  - Display the manual.
  !help - Display this help message.
```

--------------------------------------

### Manual Glados

```
Welcome to the manual !

---------------------------------------------
Add:
└─$ example -> (+ 1 2)
---------------------------------------------
Sub:
└─$ example -> (- 2 1)
---------------------------------------------
Mul:
└─$ example -> (* 2 2)
---------------------------------------------
Div:
└─$ example -> (/ 6 2)
└─$ example -> (div 6 2)
---------------------------------------------
Eq:
└─$ example -> (eq? "test" "test")
---------------------------------------------
Cond:
└─$ example -> (if (eq? 5 4) (+ 6 6) (- 7 1))
---------------------------------------------
```

--------------------------------------

### Unit Tests

```
Start:
└─$ [make test]

Packages used:
  - hspec
  - silently
```

--------------------------------------
## CI/CD

This project utilizes continuous integration and continuous deployment (CI/CD) pipelines to automate the testing and deployment processes.

- **Build and Test Workflow:** Upon every push to the `main` branch, a GitHub Actions workflow is triggered. This workflow compiles the Glados project, runs unit tests, and creates an artifact.

- **Mirror to Epitech Repo:** Additionally, the project is mirrored to the Epitech repository using a separate workflow.

- **Artifact:** The CI/CD workflow generates an artifact containing the compiled project and test results. This artifact is uploaded for further inspection or deployment.

--------------------------------------

### Project Architecture

```
├── app
│   └── Main.hs
├── CHANGELOG.md
├── examples
│   ├── call.scm
│   ├── error.scm
│   └── foo.scm
├── glados
├── glados.cabal
├── langage.bnf
├── LICENSE
├── Makefile
├── package.yaml
├── README.md
├── Setup.hs
├── src
│   ├── Ast.hs
│   ├── CommandLines.hs
│   ├── Eval.hs
│   ├── Funcs.hs
│   ├── Glados.hs
│   ├── Parser.hs
│   └── Print.hs
├── stack.yaml
├── stack.yaml.lock
└── test
    ├── AstSpec.hs
    ├── CommandLinesSpec.hs
    ├── EvalSpec.hs
    ├── FuncsSpec.hs
    ├── GladosSpec.hs
    ├── Instances.hs
    ├── Main.hs
    └── ParserSpec.hs
```

--------------------------------------

### Author

- Victor Doucet
- Hugo Mouraud
- Lucas Mechin
- Amaury Bariety
- Ashton Meuret
