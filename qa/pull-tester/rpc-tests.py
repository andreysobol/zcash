#!/usr/bin/env python2

# Copyright (c) 2014 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

#
# Run Regression Test Suite
#

import os
import sys
import subprocess
import re
from tests_config import *
from sets import Set

#If imported values are not defined then set to zero (or disabled)
if not vars().has_key('ENABLE_WALLET'):
    ENABLE_WALLET=0
if not vars().has_key('ENABLE_BITCOIND'):
    ENABLE_BITCOIND=0
if not vars().has_key('ENABLE_UTILS'):
    ENABLE_UTILS=0
if not vars().has_key('ENABLE_ZMQ'):
    ENABLE_ZMQ=0
if not vars().has_key('ENABLE_PROTON'):
    ENABLE_PROTON=0

#Create a set to store arguments and create the passOn string
opts = Set()
passOn = ""
p = re.compile("^--")
for i in range(1,len(sys.argv)):
    if (p.match(sys.argv[i]) or sys.argv[i] == "-h"):
        passOn += " " + sys.argv[i]
    else:
        opts.add(sys.argv[i])

#Set env vars
buildDir = BUILDDIR
os.environ["BITCOIND"] = buildDir + '/src/zcashd' + EXEEXT
os.environ["BITCOINCLI"] = buildDir + '/src/zcash-cli' + EXEEXT

#Tests
testScripts = [
    'paymentdisclosure.py',
    'prioritisetransaction.py',
    'wallet_treestate.py',
    'wallet_anchorfork.py',
    'wallet_protectcoinbase.py',
    'wallet_shieldcoinbase.py',
    'wallet_mergetoaddress.py',
    'wallet.py',
    'wallet_overwintertx.py',
    'wallet_nullifiers.py',
    'wallet_1941.py',
    'listtransactions.py',
    'mempool_resurrect_test.py',
    'txn_doublespend.py',
    'txn_doublespend.py --mineblock',
    'getchaintips.py',
    'rawtransactions.py',
    'rest.py',
    'mempool_spendcoinbase.py',
    'mempool_reorg.py',
    'mempool_tx_input_limit.py',
    'mempool_nu_activation.py',
    'mempool_tx_expiry.py',
    'httpbasics.py',
    'zapwallettxes.py',
    'proxy_test.py',
    'merkle_blocks.py',
    'fundrawtransaction.py',
    'signrawtransactions.py',
    'walletbackup.py',
    'key_import_export.py',
    'nodehandling.py',
    'reindex.py',
    'decodescript.py',
    'blockchain.py',
    'disablewallet.py',
    'zcjoinsplit.py',
    'zcjoinsplitdoublespend.py',
    'zkey_import_export.py',
    'reorg_limit.py',
    'getblocktemplate.py',
    'bip65-cltv-p2p.py',
    'bipdersig-p2p.py',
    'overwinter_peer_management.py',
    'rewind_index.py',
    'p2p_txexpiry_dos.py',
    'p2p_node_bloom.py',
]
testScriptsExt = [
    'getblocktemplate_longpoll.py',
    'getblocktemplate_proposals.py',
    'pruning.py',
    'forknotify.py',
    'hardforkdetection.py',
    'invalidateblock.py',
    'keypool.py',
    'receivedby.py',
    'rpcbind_test.py',
#   'script_test.py',
    'smartfees.py',
    'maxblocksinflight.py',
    'invalidblockrequest.py',
#    'forknotify.py',
    'p2p-acceptblock.py',
]

#Enable ZMQ tests
if ENABLE_ZMQ == 1:
    testScripts.append('zmq_test.py')

#Enable Proton tests
if ENABLE_PROTON == 1:
    testScripts.append('proton_test.py')

successCount = 0
failures = []

def run_test_script(testName, *args, **kwargs):
    print '=== Running testscript %s ===' % testName
    ret = subprocess.call(*args, **kwargs)
    if ret == 0:
        print '--- Success: %s ---\n' % testName
        return True
    else:
        print '"!!! FAIL: %s !!!\n' % testName
        return False

if(ENABLE_WALLET == 1 and ENABLE_UTILS == 1 and ENABLE_BITCOIND == 1):
    rpcTestDir = buildDir + '/qa/rpc-tests/'
    #Run Tests
    for i in range(len(testScripts)):
       if (len(opts) == 0 or (len(opts) == 1 and "-win" in opts ) or '-extended' in opts 
           or testScripts[i] in opts or  re.sub(".py$", "", testScripts[i]) in opts ):
            if run_test_script(
                testScripts[i],
                rpcTestDir + testScripts[i] + " --srcdir " + buildDir + '/src ' + passOn,
                shell=True):
                successCount += 1
            else:
                failures.append(testName)
	    #exit if help is called so we print just one set of instructions
            p = re.compile(" -h| --help")
            if p.match(passOn):
                sys.exit(0)

    #Run Extended Tests
    for i in range(len(testScriptsExt)):
        if ('-extended' in opts or testScriptsExt[i] in opts 
           or re.sub(".py$", "", testScriptsExt[i]) in opts):
            if run_test_script(
                testScriptsExt[i],
                rpcTestDir + testScriptsExt[i] + " --srcdir " + buildDir + '/src ' + passOn,
                shell=True):
                successCount += 1
            else:
                failures.append(testName)

    print '\n\nTests completed: %d' % (successCount + len(failures))
    print 'successes %d; failures: %d' % (successCount, len(failures))

    if failures:
        print '\nFailing tests: %s' % failures
        sys.exit(1)
    else:
        sys.exit(0)
else:
    print "No rpc tests to run. Wallet, utils, and bitcoind must all be enabled"
