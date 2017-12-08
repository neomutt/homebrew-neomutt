class Neomutt < Formula
  desc "Bringing together all the Mutt Code"
  homepage "http://www.neomutt.org/"
  url "https://github.com/neomutt/neomutt.git", :tag => "neomutt-20171208", :revision => "f43ca8617f641c253f87ca976a482f0a74fbe161"
  head "https://github.com/neomutt/neomutt.git", :branch => "master"

  option "with-debug", "Build with debug option enabled"
  option "with-s-lang", "Build against slang instead of ncurses"

  # Neomutt-specific patches
  option "with-notmuch-patch", "Apply notmuch patch"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build

  depends_on "openssl"
  depends_on "tokyo-cabinet"
  depends_on "gpgme" => :optional
  depends_on "libidn" => :optional
  depends_on "s-lang" => :optional
  depends_on "notmuch" if build.with? "notmuch-patch"

  conflicts_with "tin",
    :because => "both install mmdf.5 and mbox.5 man pages"

  def install
    # Find our docbook catalog
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"

    args = %W[
      --prefix=#{prefix}
      --with-ssl=#{Formula["openssl"].opt_prefix}
      --with-sasl
      --with-gss
      --with-tokyocabinet
    ]

    args << "--enable-gpgme" if build.with? "gpgme"
    args << "--with-slang" if build.with? "s-lang"

    # Neomutt-specific patches
    args << "--enable-notmuch" if build.with? "notmuch-patch"

    if build.with? "debug"
      args << "--enable-debug"
    else
      args << "--disable-debug"
    end

    system "./prepare", *args
    system "make"

    system "make", "install"
  end

  test do
    system bin/"neomutt", "-D"
  end
end
