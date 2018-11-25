# Script to scafold server side

## 1. Generate the base structure

1. Go into the `sources/server/` folder
2. Execute the script `../../scripts/server-scripts/01-scaffold-server-structure.ps1 -appName __APP__NAME__`

It will generate the following structure in the `server/` folder :
(example with `__APP__NAME__` set to `Formation`)

```dir
- 00-common/
    - Formation.Common/
        - Formation.Common.csproj
- 01-dal/
    - Formation.Model/
        - Formation.Model.csproj
    - Formation.Queries/
        - Formation.Queries.csproj
    - Formation.QueriesTests/
        - Formation.QueriesTests.csproj
- 02-business/
    - 01-referentiel/
        - Formation.ReferentielContract/
            - Formation.ReferentielContract.csproj
        - Formation.ReferentielImplementation/
            - Formation.ReferentielImplementation.csproj
        - Formation.ReferentielTests/
            - Formation.ReferentielTests.csproj
- 03-frontend/
- Formation.sln
```

The projects will have defaults references as follow:

- Formation.Model.csproj -> Formation.Common.csproj
- Formation.Queries.csproj -> Formation.Common.csproj
- Formation.Queries.csproj -> Formation.Model.csproj
- Formation.QueriesTests.csproj -> Formation.Queries.csproj
- Formation.ReferentielContract.csproj -> Formation.Model.csproj
- Formation.ReferentielImplementationt.csproj -> Formation.Model.csproj
- Formation.ReferentielImplementationt.csproj -> Formation.ReferentielContract.csproj
- Formation.ReferentielTests.csproj -> Formation.ReferentielImplementationt.csproj

The projects will be added to the solution file

## 2. Add a new business structure

1. Go into the `sources/server` folder
2. Execute the script `../../scripts/server-scripts/02-scaffold-business-structure.ps1 -appName __APP__NAME__ -index __INDEX__ -businessName __BUSINESS__NAME__`

It will generate the following structure in the `02-business/` folder :
(example with `__INDEX__` set to `02` and `__BUSINESS__NAME__` set to `trainers`)

```dir
- 02-business/
    - 02-trainers/
        - Formation.TrainersContract/
            - Formation.TrainersContract.csproj
        - Formation.TrainersImplementationt/
            - Formation.TrainersImplementationt.csproj
        - Formation.TrainersTests/
            - Formation.TrainersTests.csproj
```

The projects will have defaults references as follow:

- Formation.TrainersContract.csproj -> Formation.Model.csproj
- Formation.TrainersImplementationt.csproj -> Formation.Model.csproj
- Formation.TrainersImplementationt.csproj -> Formation.TrainersContract.csproj
- Formation.TrainersTests.csproj -> Formation.TrainersImplementationt.csproj

The projects will be added to the solution file

## 3. Add a new frontend

1. Go into the `sources/server` folder
2. Execute the script `../../scripts/server-scripts/03-scaffold-frontend-structure.ps1 -appName __APP__NAME__ -frontendName __FRONTEND_NAME__`

It will generate the following structure in the `02-business/` folder :
(example with `__FRONTEND_NAME__` set to `staffing`)

```dir
- 03-frontend/
    - Formation.StafingFrontend/
        - Formation.StafingFrontend.csproj
```

The projects will have defaults references as follow:

- Formation.StafingFrontend.csproj -> Formation.Model.csproj
- Formation.StafingFrontend.csproj -> Formation.Queries.csproj
- Formation.StafingFrontend.csproj -> Formation.ReferentielContract.csproj
- Formation.StafingFrontend.csproj -> Formation.ReferentielImplementationt.csproj

The projects will be added to the solution file
