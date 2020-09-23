//
//  ActionViewController.swift
//  Extension
//
//  Created by Álvaro Ávalos Hernández on 23/09/20.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //ExtensionContext permite controlar la interacción con la app principal
        //InputItems es una matriz con datos que manda la app principal para usar en la extensión
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            //inputItem contiene archivos adjuntos envuelto en como NSItemProvider
            if let itemProvider = inputItem.attachments?.first {
                //loadItem(:) le pide la item provider el item
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    print(javaScriptValues)
                }
            }
        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
