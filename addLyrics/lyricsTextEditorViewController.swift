//
//  lyricsEditorViewController.swift
//  addLyrics
//
//  Created by Jun Zhou on 7/14/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit



class lyricsTextEditorViewController: UIViewController {
    
    
    @IBOutlet weak var lyricsEditorTextView: UITextView!
    
    @IBOutlet weak var editorContainerVIew: UIView!
    
    @IBOutlet weak var ToTimeEditor: UIButton!
    
    @IBOutlet weak var songName: UILabel!
    
    var testlyrics = "哪里有彩虹告诉我\n能不能把我的愿望还给我\n为什么天这么安静\n所有的云都跑到我这里\n有没有口罩一个给我\n释怀说了太多就成真不了\n也许时间是一种解药\n也是我现在正服下的毒药\n看不见你的笑我怎么睡得着\n你的声音这么近我却抱不到\n没有地球太阳还是会绕\n没有理由我也能自己走\n你要离开\n我知道很简单\n你说依赖\n是我们的阻碍\n就算放开\n但能不能别没收我的爱\n当作我最后才明白"
    
  
    
    override func viewDidLoad() {
        
        lyricsEditorTextView.backgroundColor = UIColor(patternImage:UIImage(named: "wood.png")!)
        lyricsEditorTextView.textColor = UIColor.whiteColor()
        editorContainerVIew.backgroundColor = UIColor(patternImage:UIImage(named: "wood.png")!)
        lyricsEditorTextView.text = testlyrics
        songName.text = "彩虹"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        var destViewController: lyricsTimeEditorViewController = segue.destinationViewController as! lyricsTimeEditorViewController
//        destViewController.lyricsFromTextEditor = testlyrics
//        
//    }
    

    @IBAction func pressDeleteButton(sender: AnyObject) {
        var refreshAlert = UIAlertController(title: "Delete Lyrics", message: "Are you sure you want delete all?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            self.lyricsEditorTextView.text = ""
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
    }
    @IBAction func ToMusic(sender: AnyObject) {
        
    }
    
    
    @IBAction func ToTimeEditor(sender: AnyObject) {
        
//        //Animations
//        UIView.beginAnimations("View Flip", context: nil)
//        UIView.setAnimationDuration(0.4)
//        UIView.setAnimationCurve(.EaseInOut)
//        UIView.commitAnimations() 
        let lyricsTimeEditor = storyboard!.instantiateViewControllerWithIdentifier("lyricsTimeEditor") as! lyricsTimeEditorViewController
        lyricsTimeEditor.nameFromTextEditor = songName.text!
        if lyricsEditorTextView.text == "" {
            lyricsTimeEditor.lyricsFromTextEditor = "You don't have any lyrics"
        }else {
            lyricsTimeEditor.lyricsFromTextEditor = lyricsEditorTextView.text
        }
        self.presentViewController(lyricsTimeEditor, animated: true, completion: nil)


    }

    

    
}
