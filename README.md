# Test Driven Developemnt (TDD)
***
## Background 

Essentially you want to write the tests then write the simplest code possible to make those test passed.
Once you make the pass test go back and refactor your code.

### Red Green refactor cycle
- **Red** --> Write test that will failed 
- **Green** --> Write minmal test that will help to pass the test
- **Refactor** --> Refactor the code 

**Golden Rule of TDD**
 ```
 Never Write new Functionality without a failling test.
 ```

***
## Project Orginization

1) **Domain**
   - inner layer
   - shouldn't be susceptible to whims of changing
   - Containes bussiness logic(Use Cases) and business objects(Entites)
   - This layer is completely independent when it gets data from the repositories and this is accomplished with the help of dependecncy inversion
   ```
   Dependency Inversion
   i) High leve module shouldn't import anything form low level modules.Both should depend on abstraction
   ii) Abstractions should not depend on details. Details should depend on abstraction.
   ```
   **Folder Structure**
   domain
      - entites
      - repositories (only contracts)
      - use cases

2) **Data**

   - Repositories implementation and data sources reside in here
   - In repository implementation you have to decide from where you will get data (local or remote).

   **Folder Structure**
    data
     - datasources
     - models
     - repositories (Contracts implemetation)
     

    - *DataSources* - It returns model rather than entites.
           it have local and remote data sources
    - *Models* - It is same as the Entity but the json related logics are reside in here.

3) **Presentation**
   - All presentation related logics resides in here

   **Folder Structure**
   presentation
    - bloc
    - pages
    - widgets

***



