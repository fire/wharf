package megafile_test

import (
	"io/ioutil"
	"os"
	"testing"

	"github.com/itchio/wharf.proto/megafile"
	"github.com/stretchr/testify/assert"
)

func Test_Read(t *testing.T) {
	tmpPath := mktestdir(t, "read")
	defer os.RemoveAll(tmpPath)

	info, err := megafile.Walk(tmpPath, 16)
	must(t, err)

	r := info.NewReader(tmpPath)

	all, err := ioutil.ReadAll(r)
	must(t, err)

	assert.Equal(t, len(all), info.BlockSize*int(info.NumBlocks), "reader has right length")
	r.Close()
}