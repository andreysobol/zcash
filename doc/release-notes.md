(note: this is a temporary file, to be added-to by anybody, and moved to
release-notes at release time)

Notable changes
===============

`-mempooltxinputlimit` deprecation
----------------------------------

The configuration option `-mempooltxinputlimit` was added in release 1.0.10 as a
short-term fix for the quadratic hashing problem inherited from Bitcoin. At the
time, transactions with many inputs were causing performance issues for miners.
Since then, several performance improvements have been merged from the Bitcoin
Core codebase that significantly reduce these issues.

The Overwinter network upgrade includes changes that solve the quadratic hashing
problem, and so `-mempooltxinputlimit` will no longer be needed - a transaction
with 1000 inputs will take just as long to validate as 10 transactions with 100
inputs each. Starting from this release, `-mempooltxinputlimit` will be enforced
before the Overwinter activation height is reached, but will be ignored once
Overwinter activates. The option will be removed entirely in a future release
after Overwinter has activated.

`NODE_BLOOM` service bit
------------------------

Support for the `NODE_BLOOM` service bit, as described in [BIP
111](https://github.com/bitcoin/bips/blob/master/bip-0111.mediawiki), has been
added to the P2P protocol code.

BIP 111 defines a service bit to allow peers to advertise that they support
Bloom filters (such as used by SPV clients) explicitly. It also bumps the protocol
version to allow peers to identify old nodes which allow Bloom filtering of the
connection despite lacking the new service bit.

In this version, it is only enforced for peers that send protocol versions
`>=170004`. For the next major version it is planned that this restriction will be
removed. It is recommended to update SPV clients to check for the `NODE_BLOOM`
service bit for nodes that report version 170004 or newer.

Reduce upload traffic
---------------------

A major part of the outbound traffic is caused by serving historic blocks to
other nodes in initial block download state.

It is now possible to reduce the total upload traffic via the `-maxuploadtarget`
parameter. This is *not* a hard limit but a threshold to minimize the outbound
traffic. When the limit is about to be reached, the uploaded data is cut by not
serving historic blocks (blocks older than one week).
Moreover, any SPV peer is disconnected when they request a filtered block.

This option can be specified in MiB per day and is turned off by default
(`-maxuploadtarget=0`).
The recommended minimum is 144 * MAX_BLOCK_SIZE (currently 144MB) per day.

Whitelisted peers will never be disconnected, although their traffic counts for
calculating the target.

A more detailed documentation about keeping traffic low can be found in
[/doc/reducetraffic.md](/doc/reducetraffic.md).

Direct headers announcement (BIP 130)
-------------------------------------

Between compatible peers, BIP 130 direct headers announcement is used. This
means that blocks are advertized by announcing their headers directly, instead
of just announcing the hash. In a reorganization, all new headers are sent,
instead of just the new tip. This can often prevent an extra roundtrip before
the actual block is downloaded.
