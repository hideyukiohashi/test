
import UIKit
import WebKit

class ContentViewController: UIViewController, WKNavigationDelegate {
	var webView: WKWebView!
	var progressView: UIProgressView!
	var websites = ["apple.com", "hackingwithswift.com"]

	override func loadView() {
		webView = WKWebView()
		webView.navigationDelegate = self
		self.view = webView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let url = URL(string: "https://" + websites[0])!
		webView.load(URLRequest(url: url))
		webView.allowsBackForwardNavigationGestures = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(tappedOpen(sender:)))
		
		progressView = UIProgressView(progressViewStyle: .default)
		progressView.sizeToFit()
		let progressButton = UIBarButtonItem(customView: progressView)
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
		toolbarItems = [progressButton, spacer, refresh]
		navigationController?.isToolbarHidden = false
		
		webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@objc private func tappedOpen(sender: UIBarButtonItem) {
		let ac = UIAlertController(title: "Open page ...", message: nil, preferredStyle: .actionSheet)
		for website in websites {
			/**
			ac.addAction(UIAlertAction(title: website, style: .default, handler: { (action) in
				self.openPage(action: action)
			}))
			*/
			ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
		}
		ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
		present(ac, animated: true, completion: nil)
	}
	
	private func openPage(action: UIAlertAction) {
		let url = URL(string: "https://" + action.title!)
		webView.load(URLRequest(url: url!))
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "estimatedProgress" {
			progressView.progress = Float(webView.estimatedProgress)
		}
	}

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		navigationItem.title = webView.title
	}
	
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		let url = navigationAction.request.url
		if let host = url?.host {
			for website in websites {
				if host.range(of: website) != nil {
					print("---: \(host)")
					decisionHandler(.allow)
					return
				}
			}
		}
	}
}