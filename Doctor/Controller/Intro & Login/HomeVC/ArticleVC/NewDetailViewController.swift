import UIKit
import WebKit
import SDWebImage

class NewDetailViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var newDetailViewModel = NewDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup WKWebView delegate
        webView.navigationDelegate = self
        // Hide navigation bar
        navigationController?.isNavigationBarHidden = true
        
        // Setup ViewModel callback
        newDetailViewModel.onDataFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.updateWebViewContent()
                self?.activityIndicator.stopAnimating()
            }
        }
        
        // Fetch promotional data
        fetchPromotionalData()
    }
    
    // MARK: - Fetch Data from ViewModel
    private func fetchPromotionalData() {
        activityIndicator.startAnimating()
//        newDetailViewModel.fetchNewDetailItems ()
        BaseServiceNewsDetail.request(url: "https://gist.githubusercontent.com/CanThaiLinh/54afd6bc6efe3098f4480bf19a3739d2/raw", responseType: APINewDetailResponse.self) { [weak self] response in
            switch response {
            case .success(let success):
                debugPrint("OK")
            case .failure(let failure):
                debugPrint("fail")
            }
        }
    }
    
    // MARK: - Update WebView Content
    private func updateWebViewContent() {
        let htmlContent = generateHTMLContent()
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    // MARK: - Generate HTML Content
    private func generateHTMLContent() -> String {
        guard !newDetailViewModel.newDetailItems.isEmpty else {
            return "<html><body><h3>No promotional items available.</h3></body></html>"
        }
        
        var htmlContent = """
        <html>
        <head>
        <style>
        body { font-family: -apple-system, sans-serif; padding: 16px; }
        .item { margin-bottom: 20px; }
        .item img { width: 100%; max-width: 300px; height: auto; }
        .item h3 { font-size: 18px; }
        </style>
        </head>
        <body>
        """
        
        for item in newDetailViewModel.newDetailItems {
            if let image = newDetailViewModel.newDetailImages[item.id ?? 0] {
                // Convert image to base64 to embed in HTML
                let base64Image = image.pngData()?.base64EncodedString() ?? ""
                htmlContent += """
                <div class="item">
                    <img src="data:image/png;base64,\(base64Image)" alt="\(item.title)">
                    <h3>\(item.title)</h3>
                </div>
                """
            } else {
                // Fallback if image is not loaded yet
                htmlContent += """
                <div class="item">
                    <h3>\(item.title)</h3>
                </div>
                """
            }
        }
        
        htmlContent += "</body></html>"
        return htmlContent
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
}
