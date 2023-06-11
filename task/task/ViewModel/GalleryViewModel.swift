//
//  GalleryViewModel.swift
//  task
//
//  Created by Mac on 2023-04-26.
//

import Foundation


class GalleryViewModel: NSObject {
private var employeeService: GalleryServiceProtocol

var reloadTableView: (() -> Void)?

    var employees:Gallery?

var employeeCellViewModels = [Gallery]() {
    didSet {
        reloadTableView?()
    }
}

init(employeeService: GalleryServiceProtocol = GalleryService()) {
    self.employeeService = employeeService
}

func getEmployees() {
    employeeService.getGallery(completion: { success, model, error in
        if success, let employees = model {
            self.fetchData(employees: employees)
        } else {
            print(error!)
        }
    })
}

func fetchData(employees: Gallery) {
    self.employees = employees // Cache
    var vms = [Datum]()
    //for employee in employees.data {
      //  vms.append(createCellModel(employee: employee))
    //}
    employeeCellViewModels.append(employees)
}

func createCellModel(employee: Datum) -> GalleryViewModel {
   
    let id = employee.title
    let value = employee.image
    
  
    return GalleryViewModel()
        
}

func getCellViewModel(at indexPath: IndexPath) -> Gallery {
    print(employeeCellViewModels[indexPath.item].data.count)
    return employeeCellViewModels[indexPath.item]
    
}
}
