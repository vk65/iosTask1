//
//

import Foundation




class GalleryService: GalleryServiceProtocol {
    
    
    

    
    
    func getGallery(completion: @escaping (Bool, Gallery?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://test.dev-fsit.com/api/image-list", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Gallery.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Employees to model")
                }
            } else {
                completion(false, nil, "Error: Employees GET Request failed")
            }
        }
    }
}

protocol GalleryServiceProtocol {
    func getGallery(completion: @escaping (_ success: Bool, _ results: Gallery?, _ error: String?) -> ())
}
