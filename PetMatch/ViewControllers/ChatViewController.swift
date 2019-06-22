//
//  ChatViewController.swift
//  ChatBotPlants
//
//  Created by Francesca Valeria Haro Dávila on 2/18/19.
//  Copyright © 2019 Belatrix. All rights reserved.
//

import UIKit
import JSQMessagesViewController


class ChatViewController: JSQMessagesViewController {
  
  var messages = [JSQMessage]()
  lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
  lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.senderId = "some userId"
    self.senderDisplayName = "some userName"
    self.populateWithWelcomeMessage()
    
    
    // No avatars
    collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
    collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
    
  }
  
  func populateWithWelcomeMessage()
  {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.addMessage(withId: "BotId", name: "Bot", text: "Hey, hicimos match!")
      self.finishReceivingMessage()
    }
    
  }
  
  private func addMessage(withId id: String, name: String, text: String) {
    if let message = JSQMessage(senderId: id, displayName: name, text: text) {
      messages.append(message)
    }
  }
  
  //MARK: JSQMessageViewController Methods
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
    return messages[indexPath.item]
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
    let bubbleImageFactory = JSQMessagesBubbleImageFactory()
    return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
  }
  
  private func setupIncomingBubble() -> JSQMessagesBubbleImage {
    let bubbleImageFactory = JSQMessagesBubbleImageFactory()
    return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
  }
  
  override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
    let message = messages[indexPath.item] // 1
    if message.senderId == senderId { // 2
      return outgoingBubbleImageView
    } else { // 3
      return incomingBubbleImageView
    }
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
    let message = messages[indexPath.item]
    
    if message.senderId == senderId {
      cell.textView?.textColor = UIColor.white
    } else {
      cell.textView?.textColor = UIColor.black
    }
    return cell
  }
  
  override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
    
    addMessage(withId: senderId, name: senderDisplayName!, text: text!)
    JSQSystemSoundPlayer.jsq_playMessageSentSound()
    finishSendingMessage()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
      self.addMessage(withId: "BotId", name: "Bot", text: "Te parece si nos reunimos?")
      self.finishReceivingMessage()
    }
  }
}

