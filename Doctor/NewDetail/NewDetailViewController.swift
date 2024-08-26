import UIKit
import WebKit
import SDWebImage

class NewDetailViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet private weak var iconShareButton: UIButton!
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://www.rhinepro.vn/tin-tuc") else {return}
        let urlRequest = URLRequest(url:url)
        webView.load(urlRequest)
        webView.navigationDelegate = self
        navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    func setupUI() {
        iconShareButton.layer.cornerRadius = iconShareButton.frame.size.width/2
        backButton.layer.cornerRadius = backButton.frame.size.width/2
        iconShareButton.layer.borderWidth = 1
        iconShareButton.layer.borderColor = UIColor.gray.cgColor
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.gray.cgColor
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
}

