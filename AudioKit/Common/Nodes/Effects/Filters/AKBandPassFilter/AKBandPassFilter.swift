//
//  AKBandPassFilter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/// AudioKit version of Apple's BandPassFilter Audio Unit
///
/// - parameter input: Input node to process
/// - parameter centerFrequency: Center Frequency (Hz) ranges from 20 to 22050 (Default: 5000)
/// - parameter bandwidth: Bandwidth (Cents) ranges from 100 to 12000 (Default: 600)
///
public struct AKBandPassFilter: AKNode {
    
    private let cd = AudioComponentDescription(
        componentType: kAudioUnitType_Effect,
        componentSubType: kAudioUnitSubType_BandPassFilter,
        componentManufacturer: kAudioUnitManufacturer_Apple,
        componentFlags: 0,
        componentFlagsMask: 0)
    
    internal var internalEffect = AVAudioUnitEffect()
    internal var internalAU = AudioUnit()
    public var avAudioNode: AVAudioNode
    
    /// Center Frequency (Hz) ranges from 20 to 22050 (Default: 5000)
    public var centerFrequency: Double = 5000 {
        didSet {
            if centerFrequency < 20 {
                centerFrequency = 20
            }
            if centerFrequency > 22050 {
                centerFrequency = 22050
            }
            AudioUnitSetParameter(
                internalAU,
                kBandpassParam_CenterFrequency,
                kAudioUnitScope_Global, 0,
                Float(centerFrequency), 0)
        }
    }
    
    /// Bandwidth (Cents) ranges from 100 to 12000 (Default: 600)
    public var bandwidth: Double = 600 {
        didSet {
            if bandwidth < 100 {
                bandwidth = 100
            }
            if bandwidth > 12000 {
                bandwidth = 12000
            }
            AudioUnitSetParameter(
                internalAU,
                kBandpassParam_Bandwidth,
                kAudioUnitScope_Global, 0,
                Float(bandwidth), 0)
        }
    }
    
    /// Initialize the band pass filter node
    ///
    /// - parameter input: Input node to process
    /// - parameter centerFrequency: Center Frequency (Hz) ranges from 20 to 22050 (Default: 5000)
    /// - parameter bandwidth: Bandwidth (Cents) ranges from 100 to 12000 (Default: 600)
    ///
    public init(
        _ input: AKNode,
        centerFrequency: Double = 5000,
        bandwidth: Double = 600) {
            
            self.centerFrequency = centerFrequency
            self.bandwidth = bandwidth
            
            internalEffect = AVAudioUnitEffect(audioComponentDescription: cd)
            self.avAudioNode = internalEffect
            AKManager.sharedInstance.engine.attachNode(self.avAudioNode)
            AKManager.sharedInstance.engine.connect(input.avAudioNode, to: self.avAudioNode, format: AKManager.format)
            internalAU = internalEffect.audioUnit
            
            AudioUnitSetParameter(internalAU, kBandpassParam_CenterFrequency, kAudioUnitScope_Global, 0, Float(centerFrequency), 0)
            AudioUnitSetParameter(internalAU, kBandpassParam_Bandwidth, kAudioUnitScope_Global, 0, Float(bandwidth), 0)
    }
}
