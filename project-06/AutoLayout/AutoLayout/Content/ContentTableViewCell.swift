
import UIKit

class ContentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func showTitle(_ content: Content) {
		textLabel?.text = content.title
	}

}
