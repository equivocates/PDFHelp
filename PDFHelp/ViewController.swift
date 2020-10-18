//
//  ViewController.swift
//  PDFHelp
//
//  Created by Tom Jacob on 10/18/20.
//

import Cocoa
import PDFKit

class ViewController: NSViewController {
    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "testdoc", withExtension: "pdf") {
            pdfView.document = PDFDocument(url: url)
        }
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private var pdfAnnotationBorder:PDFBorder {
        let border = PDFBorder()
        border.lineWidth = 4.0
        border.style = .solid
        return border
    }
    
    @IBAction func addAnnotation(_ sender: Any) {
        let rect = NSRect(x: 30, y: 30, width: 30, height: 30)
        let attr:[PDFAnnotationKey:Any] = [.color: NSColor.systemYellow,
                                           .border: self.pdfAnnotationBorder]
        let annotation = PDFAnnotation(bounds: rect, forType: .text, withProperties: attr)
        pdfView.currentPage?.addAnnotation(annotation)
    }
    
}

