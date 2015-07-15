//
//  ViewController.swift
//  addLyrics
//
//  Created by Jun Zhou on 7/13/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit

import AVFoundation

var lyricsFromTextEditor: String = String()
var nameFromTextEditor: String = String()

class lyricsTimeEditorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellTableIdentifier = "CellTableIdentifier"
    var testSong: lyric = lyric()
    var audioPlayer = AVAudioPlayer()
    
    var Song_Lyrics: lyric = lyric()

    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var bar: UISlider!
    
    @IBOutlet weak var lyrics: UITableView!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "background.png")!)
        
        
        //tableView
        self.lyrics.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        lyrics.tableFooterView = UIView(frame: CGRectZero)
        lyrics.separatorColor = UIColor.clearColor()
        //lyrics.backgroundView?.alpha = 0.5
        lyrics.alpha = 0.5
      
        //self.lyrics.backgroundColor = UIColor.clearColor();
        //self.lyrics.opaque = ;
        //self.lyrics.backgroundView? = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableViewBackground.png"]];
        //self.lyrics.backgroundColor = UIColor(patternImage:UIImage(named: "background.png")!)
        println(lyricsFromTextEditor)
        
        readLineFromLyricsText()
        
        
        //testSong
//        testSong.name = "彩虹"
//        testSong.sentence.append("哪里有彩虹告诉我")
//        testSong.sentence.append("能不能把我的愿望还给我")
//        testSong.sentence.append("为什么天这么安静")
//        testSong.sentence.append("所有的云都跑到我这里")
//        testSong.sentence.append("有没有口罩一个给我")
//        testSong.sentence.append("释怀说了太多就成真不了")
//        testSong.sentence.append("也许时间是一种解药")
//        testSong.sentence.append("也是我现在正服下的毒药")
//        testSong.sentence.append("看不见妳的笑 我怎么睡得着")
//        testSong.sentence.append("妳的声音这么近我却抱不到")
//        testSong.sentence.append("没有地球 太阳还是会绕")
//        testSong.sentence.append("没有理由 我也能自己走")
//        testSong.sentence.append("妳要离开 我知道很简单")
//        testSong.sentence.append("妳说依赖 是我们的阻碍")
//        testSong.sentence.append("就算放开 但能不能别没收我的爱")
//        testSong.sentence.append("当作我最后才明白")
//        
//        testSong.time = [Float](count: testSong.sentence.count, repeatedValue: 0.0)
//        testSong.add_time = [Bool](count: testSong.sentence.count, repeatedValue: false)
        
        testSong = Song_Lyrics
        
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rainbow", ofType: "mp3")!)
        println(alertSound)
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)

        audioPlayer.prepareToPlay()
        
        bar.maximumValue = Float(audioPlayer.duration)
        bar.value = 0
        
        bar.addTarget(self, action: "changeAudioTime:", forControlEvents: UIControlEvents.ValueChanged)
        
        labelName.text = testSong.name
        labelName.textColor = UIColor.whiteColor()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("update"), userInfo: nil, repeats: true)

        
        
    }
    
    func update() {
        bar.value = Float(audioPlayer.currentTime)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeAudioTime(sender: UISlider) {
        if audioPlayer.playing == true {
            audioPlayer.stop()
            audioPlayer.currentTime = NSTimeInterval(bar.value)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } else {
            audioPlayer.currentTime = NSTimeInterval(bar.value)
        }
    }
    
    func readLineFromLyricsText() {
        var i = 0
        var end = count(lyricsFromTextEditor)
        //var firstChar = lyricsFromTextEditor[lyricsFromTextEditor.startIndex]
        //var lastChar = lyricsFromTextEditor[lyricsFromTextEditor.endIndex.predecessor()]
        var temp: String = String()
        for var index = 0; index < end; index++ {
            var charAtIndex = lyricsFromTextEditor[advance(lyricsFromTextEditor.startIndex, index)]
            if index == end {
                Song_Lyrics.sentence.append(temp)
            } else {
                if charAtIndex == "\n" {
                    Song_Lyrics.sentence.append(temp)
                    temp = ""
                    i++
                } else {
                    temp = temp + "\(charAtIndex)"
                }
            }
        }
        Song_Lyrics.name = nameFromTextEditor
        Song_Lyrics.sentence.append(temp)
        Song_Lyrics.time = [Float](count: Song_Lyrics.sentence.count, repeatedValue: 0.0)
        Song_Lyrics.add_time = [Bool](count: testSong.sentence.count, repeatedValue: false)
        
    }
    

    @IBAction func pressBackButton(sender: AnyObject) {
        let lyricsTextEditor = storyboard!.instantiateViewControllerWithIdentifier("lyricsTextEditor") as! lyricsTextEditorViewController
        self.presentViewController(lyricsTextEditor, animated: true, completion: nil)
        
    }

    @IBAction func pressplayButton(sender: AnyObject) {
        if audioPlayer.playing {
            audioPlayer.stop()
            playButton.setTitle("Play", forState: UIControlState.Normal)
        } else {
            audioPlayer.play()
            playButton.setTitle("Pause", forState: UIControlState.Normal)
        }
    }

    
    @IBAction func pressdoneButton(sender: AnyObject) {

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.lyrics.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
            
        cell.textLabel?.text = testSong.sentence[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.Center
            
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testSong.sentence.count
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var line = testSong.sentence[indexPath.row]
        println("You selected \(line)")

//        var selectedCell:UITableViewCell = lyrics.cellForRowAtIndexPath(indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.redColor()

        
        
        if testSong.add_time[indexPath.row] == false {
            var time = Float(audioPlayer.currentTime)
            testSong.time[indexPath.row] = time
            testSong.sentence[indexPath.row] = testSong.sentence[indexPath.row] + " " + "\(time)"
            testSong.add_time[indexPath.row] = true
            lyrics.reloadData()
        }else {
            audioPlayer.currentTime = NSTimeInterval(testSong.time[indexPath.row])
        }

        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete && testSong.add_time[indexPath.row] == true {
            // handle delete (by removing the data from your array and updating the tableview)
            var time = testSong.time[indexPath.row]
            var n = count(testSong.sentence[indexPath.row])
            var m = count("\(time)")
            let range = Range(start: testSong.sentence[indexPath.row].startIndex, end: advance(testSong.sentence[indexPath.row].startIndex, n - m))
            var temp = testSong.sentence[indexPath.row].substringWithRange(range)
            testSong.sentence[indexPath.row] = temp
            testSong.add_time[indexPath.row] = false
            lyrics.reloadData()
            if indexPath.row == 0 {
                audioPlayer.currentTime = NSTimeInterval(0)
            } else {
                audioPlayer.currentTime = NSTimeInterval(testSong.time[indexPath.row - 1])
            }
        }
    }
    
    

}

