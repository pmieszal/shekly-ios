import Domain
import UIKit

class CategoryListCell: UITableViewCell {
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var subcategoriesLabel: UILabel!
    @IBOutlet private weak var entryLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    func setup(with model: CategoryModel) {
        categoryLabel.text = model.name
    }
}
