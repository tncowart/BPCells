
context("Fragment IO v2")

test_that("10x Fragments round-trip", {
    dir <- withr::local_tempdir()
    
    in_path <- "../data/mini_fragments.tsv.gz"
    out_path1 <- file.path(dir, "fragments_copy1.tsv")
    out_path2 <- file.path(dir, "fragments_copy2.tsv.gz")


    input <- open_fragments_10x(in_path)
    write_fragments_10x(input, out_path1)
    write_fragments_10x(input, out_path2)

    res <- system(sprintf("bash -c \"diff -q <(gunzip -c %s) %s\"", in_path, out_path1),
        ignore.stdout = TRUE)
    expect_equal(res, 0)

    res <- system(sprintf("bash -c \"diff -q <(gunzip -c %s) <(gunzip -c %s)\"", in_path, out_path2),
        ignore.stdout = TRUE) 
    expect_equal(res, 0)
})

test_that("Packed Fragments example data round-trip", {
    in_path <- "../data/mini_fragments.tsv.gz"
    raw_fragments <- write_fragments_memory(open_fragments_10x(in_path), compress=FALSE)
    packed_fragments <- write_fragments_memory(raw_fragments)
    raw_fragments2 <- write_fragments_memory(packed_fragments, compress=FALSE)
    
    expect_equal(raw_fragments, raw_fragments2)
})

test_that("Unpacked Fragments example data round-trip", {
    in_path <- "../data/mini_fragments.tsv.gz"
    raw_fragments <- write_fragments_memory(open_fragments_10x(in_path), compress=FALSE)
    packed_fragments <- write_fragments_memory(raw_fragments, compress=FALSE)
    raw_fragments2 <- write_fragments_memory(packed_fragments, compress=FALSE)
    
    expect_equal(raw_fragments, raw_fragments2)
})

test_that("Binary File Fragments example data round-trip", {
    dir <- withr::local_tempdir()

    in_path <- "../data/mini_fragments.tsv.gz"
    raw_fragments <- write_fragments_memory(open_fragments_10x(in_path), compress=FALSE)
    
    write_fragments_dir(raw_fragments, file.path(dir, "unpacked"), compress=FALSE)
    write_fragments_dir(raw_fragments, file.path(dir, "packed"), compress=TRUE)
    
    unpacked <- open_fragments_dir(file.path(dir, "unpacked"))
    packed <- open_fragments_dir(file.path(dir, "packed"))
    
    expect_equal(raw_fragments, write_fragments_memory(unpacked, compress=FALSE))
    expect_equal(raw_fragments, write_fragments_memory(packed, compress=FALSE))
})


test_that("HDF5 File Fragments example data round-trip", {
    dir <- withr::local_tempdir()

    in_path <- "../data/mini_fragments.tsv.gz"
    raw_fragments <- write_fragments_memory(open_fragments_10x(in_path), compress=FALSE)
    
    write_fragments_hdf5(raw_fragments, file.path(dir, "file.h5"), "unpacked", compress=FALSE)
    write_fragments_hdf5(raw_fragments, file.path(dir, "file.h5"), "packed", compress=TRUE)

    unpacked <- open_fragments_hdf5(file.path(dir, "file.h5"), "unpacked")
    packed <- open_fragments_hdf5(file.path(dir, "file.h5"), "packed")
    
    expect_equal(raw_fragments, write_fragments_memory(unpacked, compress=FALSE))
    expect_equal(raw_fragments, write_fragments_memory(packed, compress=FALSE))
})