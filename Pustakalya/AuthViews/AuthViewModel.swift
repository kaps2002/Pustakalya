import Foundation

@Observable
class AuthViewModel {
    var email: String = ""
    var password: String = ""
    var isEmailValid: Bool = true
    var isPasswordValid: Bool = true
    var isSecured: Bool = true
    var name: String = ""
    var isNameValid: Bool = true
    var isAlert: Bool = false
    var isLoading: Bool = false
    var signInModelData: AuthModelData?
    var signUpModelData : AuthModelData?
    var commonViewModel = CommonViewModel()
    var isShowNextUI: Bool = false
    
    func validation(email: String, password: String) -> Int {
        if email.isEmpty {
            return 1;
        } else if password.isEmpty {
            return 2;
        }
        return  3;
    } 
    
    func signin(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let parameters: [String: String] = ["email": email, "password": password]
        APIManager.shared.request(from: "https://pustakalya.vercel.app/api/login", parameters: parameters) { [self] (success: Bool, response: AuthModelData?) in
            if success {
                // Handle successful response
                if let responseData = response {
                    signInModelData = responseData
                    UserDefaults.standard.setValue(signInModelData?.token, forKey: "authToken")
                    completion(true)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func signUp(email: String, password: String, name: String, completion: @escaping(Bool) -> Void) {
        let parameters: [String: String] = ["name": name, "email": email, "password": password]
        APIManager.shared.signupRequest(from: "https://pustakalya.vercel.app/api/signup", parameters: parameters) { [self] (success: Bool, response: AuthModelData?) in
            if success {
                if let responseData = response {
                    signUpModelData = responseData
                    UserDefaults.standard.setValue(signUpModelData?.token, forKey: "authToken")
                    completion(true)
                }
                
            } else {
                completion(false)
            }
        }
    }
    
    func verifyCode(code: String, authToken: String, completion: @escaping(Bool)->Void) {
        let parameters: [String: String] = ["code": code]
        APIManager.shared.verifyEmail(from: "https://pustakalya.vercel.app/api/verify", authToken, parameters: parameters) { result in
            if result {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
