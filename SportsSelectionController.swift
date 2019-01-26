class SportsSelectionController: FormViewController {
    
    var sports = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sports"
        
        // Turn enums into array of string
        for sport in Sports.allValues {
            sports.insert(sport.rawValue, at: sports.endIndex)
        }
        // Sort
        self.sports.sort()
        
        self.setupForm()
    }
    
    func setupForm() {
        // Build form for sports
        form +++
            MultivaluedSection(multivaluedOptions: [.Insert, .Delete],
                               header: "", footer: "") {
                                
                                // Declare an empty section
                                let section =  $0
                                
                                // Get the sport values for the current user
                                TrainerServices.shared.getSportsValues { (sportsValues) in
                                    print(sportsValues)
                                    
                                    var counter = 0
                                    // Declare a row
                                    var row: PushRow<String>
                                    
                                    // Must provide tags in order to save
                                    for sport in sportsValues {
                                        let tag = "tag_\(counter)"
                                        
                                        // Initialize a row with its properties
                                        // baseValue property is the value of the row
                                        row = PushRow<String>(tag) {
                                            $0.options = self.sports
                                            $0.title = "Tap to modify"
                                            $0.baseValue = sport
                                        }
                                        
                                        self.form.setValues([tag : sport])
                                        
                                        section.append(row)
                                        counter += 1
                                        
                                    }
                                    // Do no move this
                                    // in this structure, 'Add' is first row
                                    // Remove now and save for later
                                    let firstRow = section.remove(at: 0)
                                    
                                    // Adds new row after pressing "Add" row
                                    section.multivaluedRowToInsertAt = { index in
                                        // index is the row number, makes each tag unique
                                        return PushRow<String>("tag_\(index)"){
                                            
                                            $0.title = "Tap to add a sport"
                                            $0.options = self.sports
                                            
                                        }
                                    }
                                    
                                    // Add the firstRow at the end of the table
                                    section.append(firstRow)
                                }
                                
        }
        
        //        form +++ ButtonRow(){
        //            $0.title = "Add another sport"
        //            }.onCellSelection({ (cell, row) in
        //
        //            })
        
        form +++ ButtonRow(){
            $0.title = "Save"
            }.onCellSelection({ (cell, row) in
                
                
                // Get the value of all rows which have a Tag assigned
                // The dictionary contains the 'rowTag':value pairs.
                let dict = self.form.values()
                print(dict)
                
                // TODO
                if dict.count > 0 {
                    for (_, tagVal) in dict {
                        if tagVal == nil {
                            self.showAlertOK(title: "Form Error", message: "Please select at least 1 sport.")
                            return
                        }
                    }
                    
                    let selectionValues = Array(dict.values) as! Array<String>
                    
                    TrainerServices.shared.saveSportsValues(sports: selectionValues)
                }
            })
    }
    
    func showAlertOK(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
}
