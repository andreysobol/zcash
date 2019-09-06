rust_crates := \
  crate_aes \
  crate_aesni \
  crate_aes_soft \
  crate_aho_corasick \
  crate_ansi_term \
  crate_arrayref \
  crate_arrayvec \
  crate_autocfg \
  crate_bech32 \
  crate_bit_vec \
  crate_bitflags \
  crate_blake2b_simd \
  crate_blake2s_simd \
  crate_block_buffer \
  crate_block_cipher_trait \
  crate_block_padding \
  crate_byte_tools \
  crate_byteorder \
  crate_c2_chacha \
  crate_cfg_if \
  crate_chrono \
  crate_cloudabi \
  crate_constant_time_eq \
  crate_crossbeam \
  crate_crossbeam_utils \
  crate_crypto_api_chachapoly \
  crate_crypto_api \
  crate_digest \
  crate_directories \
  crate_fake_simd \
  crate_fpe \
  crate_futures_cpupool \
  crate_futures \
  crate_generic_array \
  crate_getrandom \
  crate_hex \
  crate_lazy_static \
  crate_libc \
  crate_lock_api \
  crate_log \
  crate_matchers \
  crate_memchr \
  crate_nodrop \
  crate_num_bigint \
  crate_num_cpus \
  crate_num_integer \
  crate_num_traits \
  crate_opaque_debug \
  crate_owning_ref \
  crate_parking_lot \
  crate_parking_lot_core \
  crate_ppv_lite86 \
  crate_proc_macro2_0_4_30 \
  crate_proc_macro2 \
  crate_quote_0_6_13 \
  crate_quote \
  crate_rand_chacha \
  crate_rand_core \
  crate_rand_hc \
  crate_rand_os \
  crate_rand_xorshift \
  crate_rand \
  crate_redox_syscall \
  crate_regex \
  crate_regex_automata \
  crate_regex_syntax \
  crate_rustc_version \
  crate_scopeguard \
  crate_semver \
  crate_semver_parser \
  crate_sha2 \
  crate_smallvec \
  crate_spin \
  crate_stable_deref_trait \
  crate_syn_0_14_9 \
  crate_syn \
  crate_thread_local \
  crate_time \
  crate_tracing \
  crate_tracing_attributes \
  crate_tracing_core \
  crate_tracing_log \
  crate_tracing_subscriber \
  crate_typenum \
  crate_unicode_xid_0_1_0 \
  crate_unicode_xid \
  crate_utf8_ranges \
  crate_winapi_i686_pc_windows_gnu \
  crate_winapi \
  crate_winapi_x86_64_pc_windows_gnu
rust_packages := rust $(rust_crates) librustzcash
proton_packages := proton
zcash_packages := libgmp libsodium
packages := boost openssl libevent zeromq $(zcash_packages) googletest
native_packages := native_ccache

wallet_packages=bdb
