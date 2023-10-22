# TheMovieDB
<Task Summary>: We need to request movies remote Info and display on Screen
- note: check the file of the task 

Displaying movies remote data on the screen using MVVM-C
# Task Analysis
- Depending on the task requirments I find that we have 3 main parts that's required 
    - Presentation: To map UI data on screen
    - Domain: To Achieve the business rules required 
    - Data: To handle the dealing with data
    - Navigations required    
    
<Applied architecture design pattern>: I'm finding the MVX-C is a suitable design pattern because:-
    - Presenter/ViewModel: Great In handling Presentation and business logic
    - Make the project more easier to be tested and flexible 
    - Separating navigation in a coordinator leverage the flexibility of reusing views 
    
=> I prefer to use Presenter for this project over ViewModel. I don't need binding and I need more clear separation of concerns making the viewController totally agnostic about what's going on
=> I'm also going to Implement the ViewModel case  
    

# Architecture (Layers) 
 architecture is about responsibilities and how those components talk to each other 

    ## Presentation
    For UIKit 
    - View: set the data sent by presenter    
    - ViewController: map the data to the view 
    - Presenter: Handle data comes from UseCases and send to controllers
    For SwiftUI
    _ View: Bind the data from ViewModel  
    - ViewModel: Handle data comes from appropriate use case 
    ## Domain
    - Entity: Business Models
    - UseCase: Business Functions
    - Repositories Contracts: Required Data from repo (dependency inversion) 
    ## Data
    - Repository:  
    - RemoteDataSource: responsible for fetching data from remote  
    ## Network
    - NetworkManager: map remote data to DTO object 
    - SessionClient: request remote data using Rest Methods 
     

 
