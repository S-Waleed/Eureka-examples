form +++
            
            Section(header: "Personal Information", footer: "Complete all fields.")
            
            //            <<< NameRow() {
            //                $0.title = "Full Name *"
            //                $0.placeholder = "Janne Doe"
            //                $0.tag = "fullName"
            //                $0.add(rule: RuleRequired())
            //
            //                }.cellUpdate { cell, row in
            //                    if !row.isValid {
            //                        cell.titleLabel?.textColor = .red
            //                        cell.titleLabel?.text = "Full Name: Field required!"
            //                    } else {
            //                        cell.titleLabel?.textColor = navyColor
            //                        cell.titleLabel?.text = "Full Name *"
            //                    }
            //            }
            
           
            +++ Section("Skills")
            <<< ButtonRow(){
                $0.title = "Sports"
                $0.add(rule: RuleRequired())
                $0.presentationMode = .show(controllerProvider: .callback(builder: {
                    let viewCtrlr = SportsSelectionController()
                    return viewCtrlr
                }), onDismiss:nil)
                
            }
