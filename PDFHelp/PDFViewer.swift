//
//  PDFViewer.swift
//  PDFHelp
//
//  Created by Tom Jacob on 10/22/20.
//

import Cocoa
import PDFKit

class PDFViewer: PDFView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    private var annotationBeingDragged:PDFAnnotation?

    override func mouseDown(with event: NSEvent) {
        let areaOfInterest = self.areaOfInterest(forMouse: event)
        
        if areaOfInterest.contains(.annotationArea),
            let currentPage = self.currentPage,
            let annotation = currentPage.annotation(at: self.convert(self.convert(event.locationInWindow, from: nil), to: currentPage)) {

            if annotationBeingDragged == nil {
                annotationBeingDragged = annotation
            } else {
                super.mouseDown(with: event)
            }
        }
        else {
            super.mouseDown(with: event)
        }
    }

    override func mouseDragged(with event: NSEvent) {

        if let annotation = annotationBeingDragged,
            let currentPage = self.currentPage {
            
                currentPage.removeAnnotation(annotation)
                let currentPoint = self.convert(self.convert(event.locationInWindow, from: nil), to: currentPage)
                annotation.bounds = NSRect(origin: currentPoint, size: annotation.bounds.size)
                currentPage.addAnnotation(annotation)
        }
        else {
            super.mouseDragged(with: event)
        }
    }

    override func mouseUp(with event: NSEvent) {
        if annotationBeingDragged != nil {
            annotationBeingDragged = nil
            super.mouseDown(with: event)
        }
        else {
            super.mouseUp(with: event)
        }
    }
    
}
