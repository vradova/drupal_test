-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 16, 2020 at 09:50 AM
-- Server version: 10.4.12-MariaDB
-- PHP Version: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drupal_test_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_actions`
--

CREATE TABLE `jbqo_actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

--
-- Dumping data for table `jbqo_actions`
--

INSERT INTO `jbqo_actions` (`aid`, `type`, `callback`, `parameters`, `label`) VALUES
('comment_publish_action', 'comment', 'comment_publish_action', '', 'Publish comment'),
('comment_save_action', 'comment', 'comment_save_action', '', 'Save comment'),
('comment_unpublish_action', 'comment', 'comment_unpublish_action', '', 'Unpublish comment'),
('node_make_sticky_action', 'node', 'node_make_sticky_action', '', 'Make content sticky'),
('node_make_unsticky_action', 'node', 'node_make_unsticky_action', '', 'Make content unsticky'),
('node_promote_action', 'node', 'node_promote_action', '', 'Promote content to front page'),
('node_publish_action', 'node', 'node_publish_action', '', 'Publish content'),
('node_save_action', 'node', 'node_save_action', '', 'Save content'),
('node_unpromote_action', 'node', 'node_unpromote_action', '', 'Remove content from front page'),
('node_unpublish_action', 'node', 'node_unpublish_action', '', 'Unpublish content'),
('system_block_ip_action', 'user', 'system_block_ip_action', '', 'Ban IP address of current user'),
('user_block_user_action', 'user', 'user_block_user_action', '', 'Block current user');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_authmap`
--

CREATE TABLE `jbqo_authmap` (
  `aid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT 'User’s `jbqo_users`.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_batch`
--

CREATE TABLE `jbqo_batch` (
  `bid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob DEFAULT NULL COMMENT 'A serialized array containing the processing data for the batch.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_block`
--

CREATE TABLE `jbqo_block` (
  `bid` int(11) NOT NULL COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';

--
-- Dumping data for table `jbqo_block`
--

INSERT INTO `jbqo_block` (`bid`, `module`, `delta`, `theme`, `status`, `weight`, `region`, `custom`, `visibility`, `pages`, `title`, `cache`) VALUES
(1, 'system', 'main', 'bartik', 1, 0, 'content', 0, 0, '', '', -1),
(2, 'search', 'form', 'bartik', 1, -1, 'sidebar_first', 0, 0, '', '', -1),
(3, 'node', 'recent', 'seven', 0, 10, '-1', 0, 0, '', '', -1),
(4, 'user', 'login', 'bartik', 1, 0, 'sidebar_first', 0, 0, '', '', -1),
(5, 'system', 'navigation', 'bartik', 1, 0, 'sidebar_first', 0, 0, '', '', -1),
(6, 'system', 'powered-by', 'bartik', 1, 10, 'footer', 0, 0, '', '', -1),
(7, 'system', 'help', 'bartik', 1, 0, 'help', 0, 0, '', '', -1),
(8, 'system', 'main', 'seven', 1, 0, 'content', 0, 0, '', '', -1),
(9, 'system', 'help', 'seven', 1, 0, 'help', 0, 0, '', '', -1),
(10, 'user', 'login', 'seven', 1, 10, 'content', 0, 0, '', '', -1),
(11, 'user', 'new', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(12, 'search', 'form', 'seven', 0, -10, '-1', 0, 0, '', '', -1),
(13, 'comment', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(14, 'node', 'syndicate', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(15, 'node', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(16, 'shortcut', 'shortcuts', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(17, 'system', 'management', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(18, 'system', 'user-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(19, 'system', 'main-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(20, 'user', 'new', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(21, 'user', 'online', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(22, 'comment', 'recent', 'seven', 0, 0, '-1', 0, 0, '', '', 1),
(23, 'node', 'syndicate', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(24, 'shortcut', 'shortcuts', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(25, 'system', 'powered-by', 'seven', 0, 10, '-1', 0, 0, '', '', -1),
(26, 'system', 'navigation', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(27, 'system', 'management', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(28, 'system', 'user-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(29, 'system', 'main-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(30, 'user', 'online', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(31, 'devel', 'execute_php', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(32, 'devel', 'switch_user', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(33, 'menu', 'devel', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(34, 'devel', 'execute_php', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(35, 'devel', 'switch_user', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(36, 'menu', 'devel', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(37, 'menu', 'features', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(38, 'menu', 'features', 'seven', 0, 0, '-1', 0, 0, '', '', -1);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_blocked_ips`
--

CREATE TABLE `jbqo_blocked_ips` (
  `iid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_block_custom`
--

CREATE TABLE `jbqo_block_custom` (
  `bid` int(10) UNSIGNED NOT NULL COMMENT 'The block’s `jbqo_block`.bid.',
  `body` longtext DEFAULT NULL COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The `jbqo_filter_format`.format of the block body.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_block_node_type`
--

CREATE TABLE `jbqo_block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from `jbqo_block`.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from `jbqo_block`.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from `jbqo_node_type`.type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_block_role`
--

CREATE TABLE `jbqo_block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from `jbqo_block`.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from `jbqo_block`.delta.',
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'The user’s role ID from `jbqo_users_roles`.rid.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache`
--

CREATE TABLE `jbqo_cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_block`
--

CREATE TABLE `jbqo_cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_bootstrap`
--

CREATE TABLE `jbqo_cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_features`
--

CREATE TABLE `jbqo_cache_features` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for features to store module info.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_field`
--

CREATE TABLE `jbqo_cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_filter`
--

CREATE TABLE `jbqo_cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_form`
--

CREATE TABLE `jbqo_cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_image`
--

CREATE TABLE `jbqo_cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_menu`
--

CREATE TABLE `jbqo_cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

--
-- Dumping data for table `jbqo_cache_menu`
--

INSERT INTO `jbqo_cache_menu` (`cid`, `data`, `expire`, `created`, `serialized`) VALUES
('menu_custom', 0x613a363a7b733a353a22646576656c223b613a333a7b733a393a226d656e755f6e616d65223b733a353a22646576656c223b733a353a227469746c65223b733a31313a22446576656c6f706d656e74223b733a31313a226465736372697074696f6e223b733a31363a22446576656c6f706d656e74206c696e6b223b7d733a383a226665617475726573223b613a333a7b733a393a226d656e755f6e616d65223b733a383a226665617475726573223b733a353a227469746c65223b733a383a224665617475726573223b733a31313a226465736372697074696f6e223b733a33363a224d656e75206974656d7320666f7220616e7920656e61626c65642066656174757265732e223b7d733a393a226d61696e2d6d656e75223b613a333a7b733a393a226d656e755f6e616d65223b733a393a226d61696e2d6d656e75223b733a353a227469746c65223b733a393a224d61696e206d656e75223b733a31313a226465736372697074696f6e223b733a3131353a22546865203c656d3e4d61696e3c2f656d3e206d656e752069732075736564206f6e206d616e7920736974657320746f2073686f7720746865206d616a6f722073656374696f6e73206f662074686520736974652c206f6674656e20696e206120746f70206e617669676174696f6e206261722e223b7d733a31303a226d616e6167656d656e74223b613a333a7b733a393a226d656e755f6e616d65223b733a31303a226d616e6167656d656e74223b733a353a227469746c65223b733a31303a224d616e6167656d656e74223b733a31313a226465736372697074696f6e223b733a36393a22546865203c656d3e4d616e6167656d656e743c2f656d3e206d656e7520636f6e7461696e73206c696e6b7320666f722061646d696e697374726174697665207461736b732e223b7d733a31303a226e617669676174696f6e223b613a333a7b733a393a226d656e755f6e616d65223b733a31303a226e617669676174696f6e223b733a353a227469746c65223b733a31303a224e617669676174696f6e223b733a31313a226465736372697074696f6e223b733a3135303a22546865203c656d3e4e617669676174696f6e3c2f656d3e206d656e7520636f6e7461696e73206c696e6b7320696e74656e64656420666f7220736974652076697369746f72732e204c696e6b732061726520616464656420746f20746865203c656d3e4e617669676174696f6e3c2f656d3e206d656e75206175746f6d61746963616c6c7920627920736f6d65206d6f64756c65732e223b7d733a393a22757365722d6d656e75223b613a333a7b733a393a226d656e755f6e616d65223b733a393a22757365722d6d656e75223b733a353a227469746c65223b733a393a2255736572206d656e75223b733a31313a226465736372697074696f6e223b733a39393a22546865203c656d3e557365723c2f656d3e206d656e7520636f6e7461696e73206c696e6b732072656c6174656420746f2074686520757365722773206163636f756e742c2061732077656c6c2061732074686520274c6f67206f757427206c696e6b2e223b7d7d, 0, 1608106274, 1);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_page`
--

CREATE TABLE `jbqo_cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_path`
--

CREATE TABLE `jbqo_cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_update`
--

CREATE TABLE `jbqo_cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_views`
--

CREATE TABLE `jbqo_cache_views` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_cache_views_data`
--

CREATE TABLE `jbqo_cache_views_data` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob DEFAULT NULL COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT 1 COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_comment`
--

CREATE TABLE `jbqo_comment` (
  `cid` int(11) NOT NULL COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_comment`.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node`.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT 0 COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses `jbqo_users`.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The `jbqo_languages`.language of this comment.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_ctools_css_cache`
--

CREATE TABLE `jbqo_ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext DEFAULT NULL COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_ctools_object_cache`
--

CREATE TABLE `jbqo_ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(128) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The time this cache was created or updated.',
  `data` longblob DEFAULT NULL COMMENT 'Serialized data being stored.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_date_formats`
--

CREATE TABLE `jbqo_date_formats` (
  `dfid` int(10) UNSIGNED NOT NULL COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Whether or not this format can be modified.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';

--
-- Dumping data for table `jbqo_date_formats`
--

INSERT INTO `jbqo_date_formats` (`dfid`, `format`, `type`, `locked`) VALUES
(1, 'm/d/Y - H:i', 'short', 1),
(2, 'd/m/Y - H:i', 'short', 1),
(3, 'Y/m/d - H:i', 'short', 1),
(4, 'd.m.Y - H:i', 'short', 1),
(5, 'Y-m-d H:i', 'short', 1),
(6, 'm/d/Y - g:ia', 'short', 1),
(7, 'd/m/Y - g:ia', 'short', 1),
(8, 'Y/m/d - g:ia', 'short', 1),
(9, 'M j Y - H:i', 'short', 1),
(10, 'j M Y - H:i', 'short', 1),
(11, 'Y M j - H:i', 'short', 1),
(12, 'M j Y - g:ia', 'short', 1),
(13, 'j M Y - g:ia', 'short', 1),
(14, 'Y M j - g:ia', 'short', 1),
(15, 'D, m/d/Y - H:i', 'medium', 1),
(16, 'D, d/m/Y - H:i', 'medium', 1),
(17, 'D, Y/m/d - H:i', 'medium', 1),
(18, 'D, Y-m-d H:i', 'medium', 1),
(19, 'F j, Y - H:i', 'medium', 1),
(20, 'j F, Y - H:i', 'medium', 1),
(21, 'Y, F j - H:i', 'medium', 1),
(22, 'D, m/d/Y - g:ia', 'medium', 1),
(23, 'D, d/m/Y - g:ia', 'medium', 1),
(24, 'D, Y/m/d - g:ia', 'medium', 1),
(25, 'F j, Y - g:ia', 'medium', 1),
(26, 'j F Y - g:ia', 'medium', 1),
(27, 'Y, F j - g:ia', 'medium', 1),
(28, 'j. F Y - G:i', 'medium', 1),
(29, 'l, F j, Y - H:i', 'long', 1),
(30, 'l, j F, Y - H:i', 'long', 1),
(31, 'l, Y,  F j - H:i', 'long', 1),
(32, 'l, F j, Y - g:ia', 'long', 1),
(33, 'l, j F Y - g:ia', 'long', 1),
(34, 'l, Y,  F j - g:ia', 'long', 1),
(35, 'l, j. F Y - G:i', 'long', 1);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_date_format_locale`
--

CREATE TABLE `jbqo_date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A `jbqo_languages`.language for this format to be used with.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_date_format_type`
--

CREATE TABLE `jbqo_date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Whether or not this is a system provided format.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

--
-- Dumping data for table `jbqo_date_format_type`
--

INSERT INTO `jbqo_date_format_type` (`type`, `title`, `locked`) VALUES
('long', 'Long', 1),
('medium', 'Medium', 1),
('short', 'Short', 1);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_features_signature`
--

CREATE TABLE `jbqo_features_signature` (
  `module` varchar(64) NOT NULL COMMENT 'Name of the feature module.',
  `component` varchar(128) NOT NULL COMMENT 'Name of the features component.',
  `signature` varchar(128) NOT NULL COMMENT 'Hash reflecting the last approved state of the component in code.',
  `updated` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp when the signature was last updated.',
  `message` varchar(255) DEFAULT NULL COMMENT 'Message to document why the component was updated.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores hashes that reflect the last known state of a...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_config`
--

CREATE TABLE `jbqo_field_config` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT 0 COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT 0,
  `translatable` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jbqo_field_config`
--

INSERT INTO `jbqo_field_config` (`id`, `field_name`, `type`, `module`, `active`, `storage_type`, `storage_module`, `storage_active`, `locked`, `data`, `cardinality`, `translatable`, `deleted`) VALUES
(1, 'comment_body', 'text_long', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(2, 'body', 'text_with_summary', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a343a226e6f6465223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(3, 'field_tags', 'taxonomy_term_reference', 'taxonomy', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a383a2273657474696e6773223b613a313a7b733a31343a22616c6c6f7765645f76616c756573223b613a313a7b693a303b613a323a7b733a31303a22766f636162756c617279223b733a343a2274616773223b733a363a22706172656e74223b693a303b7d7d7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b623a303b733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22746964223b613a323a7b733a353a227461626c65223b733a31383a227461786f6e6f6d795f7465726d5f64617461223b733a373a22636f6c756d6e73223b613a313a7b733a333a22746964223b733a333a22746964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22746964223b613a313a7b693a303b733a333a22746964223b7d7d7d, -1, 0, 0),
(4, 'field_image', 'image', 'image', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a373a22696e6465786573223b613a313a7b733a333a22666964223b613a313a7b693a303b733a333a22666964223b7d7d733a383a2273657474696e6773223b613a323a7b733a31303a227572695f736368656d65223b733a363a227075626c6963223b733a31333a2264656661756c745f696d616765223b623a303b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b623a303b733a31323a22666f726569676e206b657973223b613a313a7b733a333a22666964223b613a323a7b733a353a227461626c65223b733a31323a2266696c655f6d616e61676564223b733a373a22636f6c756d6e73223b613a313a7b733a333a22666964223b733a333a22666964223b7d7d7d7d, 1, 0, 0),
(5, 'field_employment_type', 'list_text', 'list', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a323a7b733a31343a22616c6c6f7765645f76616c756573223b613a333a7b693a313b733a393a2246756c6c2074696d65223b693a323b733a393a22506172742074696d65223b693a333b733a393a22467265656c616e6365223b7d733a32333a22616c6c6f7765645f76616c7565735f66756e6374696f6e223b733a303a22223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33323a226669656c645f646174615f6669656c645f656d706c6f796d656e745f74797065223b613a313a7b733a353a2276616c7565223b733a32373a226669656c645f656d706c6f796d656e745f747970655f76616c7565223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33363a226669656c645f7265766973696f6e5f6669656c645f656d706c6f796d656e745f74797065223b613a313a7b733a353a2276616c7565223b733a32373a226669656c645f656d706c6f796d656e745f747970655f76616c7565223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a303a7b7d733a373a22696e6465786573223b613a313a7b733a353a2276616c7565223b613a313a7b693a303b733a353a2276616c7565223b7d7d733a323a226964223b733a313a2235223b7d, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_config_instance`
--

CREATE TABLE `jbqo_field_config_instance` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jbqo_field_config_instance`
--

INSERT INTO `jbqo_field_config_instance` (`id`, `field_id`, `field_name`, `entity_type`, `bundle`, `data`, `deleted`) VALUES
(1, 1, 'comment_body', 'comment', 'comment_node_page', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(2, 2, 'body', 'node', 'page', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(3, 1, 'comment_body', 'comment', 'comment_node_article', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(4, 2, 'body', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(5, 3, 'field_tags', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a2254616773223b733a31313a226465736372697074696f6e223b733a36333a22456e746572206120636f6d6d612d736570617261746564206c697374206f6620776f72647320746f20646573637269626520796f757220636f6e74656e742e223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32313a227461786f6e6f6d795f6175746f636f6d706c657465223b733a363a22776569676874223b693a2d343b733a383a2273657474696e6773223b613a323a7b733a343a2273697a65223b693a36303b733a31373a226175746f636f6d706c6574655f70617468223b733a32313a227461786f6e6f6d792f6175746f636f6d706c657465223b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b693a31303b733a353a226c6162656c223b733a353a2261626f7665223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a353a7b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b693a31303b733a353a226c6162656c223b733a353a2261626f7665223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a303b7d, 0),
(6, 4, 'field_image', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a353a22496d616765223b733a31313a226465736372697074696f6e223b733a34303a2255706c6f616420616e20696d61676520746f20676f207769746820746869732061727469636c652e223b733a383a227265717569726564223b623a303b733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a31313a226669656c642f696d616765223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b623a313b733a31313a227469746c655f6669656c64223b733a303a22223b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a363a226d656469756d223b733a31303a22696d6167655f6c696e6b223b733a373a22636f6e74656e74223b7d733a363a22776569676874223b693a2d313b733a363a226d6f64756c65223b733a353a22696d616765223b7d7d7d, 0),
(7, 1, 'comment_body', 'comment', 'comment_node_job', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(8, 2, 'body', 'node', 'job', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b733a323a222d34223b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(9, 5, 'field_employment_type', 'node', 'job', 0x613a373a7b733a353a226c6162656c223b733a31353a22456d706c6f796d656e742074797065223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a323a222d33223b733a343a2274797065223b733a31343a226f7074696f6e735f73656c656374223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a303a7b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a31323a226c6973745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a226c697374223b733a363a22776569676874223b693a313b7d7d733a383a227265717569726564223b693a313b733a31313a226465736372697074696f6e223b733a32323a2243686f6f7365207468652074797065206f66206a6f62223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_data_body`
--

CREATE TABLE `jbqo_field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext DEFAULT NULL,
  `body_summary` longtext DEFAULT NULL,
  `body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';

--
-- Dumping data for table `jbqo_field_data_body`
--

INSERT INTO `jbqo_field_data_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `body_value`, `body_summary`, `body_format`) VALUES
('node', 'article', 0, 1, 1, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. \r\n\r\nDuis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. ', '', 'filtered_html'),
('node', 'job', 0, 2, 2, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ', '', 'filtered_html'),
('node', 'job', 0, 3, 3, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\r\n\r\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html'),
('node', 'job', 0, 4, 4, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\r\n\r\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html'),
('node', 'job', 0, 5, 5, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html'),
('node', 'job', 0, 6, 6, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_data_comment_body`
--

CREATE TABLE `jbqo_field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext DEFAULT NULL,
  `comment_body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_data_field_employment_type`
--

CREATE TABLE `jbqo_field_data_field_employment_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_employment_type_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (field_employment_type)';

--
-- Dumping data for table `jbqo_field_data_field_employment_type`
--

INSERT INTO `jbqo_field_data_field_employment_type` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_employment_type_value`) VALUES
('node', 'job', 0, 2, 2, 'und', 0, '1'),
('node', 'job', 0, 3, 3, 'und', 0, '2'),
('node', 'job', 0, 4, 4, 'und', 0, '3'),
('node', 'job', 0, 5, 5, 'und', 0, '3'),
('node', 'job', 0, 6, 6, 'und', 0, '1');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_data_field_image`
--

CREATE TABLE `jbqo_field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The `jbqo_file_managed`.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) UNSIGNED DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) UNSIGNED DEFAULT NULL COMMENT 'The height of the image in pixels.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_data_field_tags`
--

CREATE TABLE `jbqo_field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_revision_body`
--

CREATE TABLE `jbqo_field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext DEFAULT NULL,
  `body_summary` longtext DEFAULT NULL,
  `body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';

--
-- Dumping data for table `jbqo_field_revision_body`
--

INSERT INTO `jbqo_field_revision_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `body_value`, `body_summary`, `body_format`) VALUES
('node', 'article', 0, 1, 1, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. \r\n\r\nDuis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. ', '', 'filtered_html'),
('node', 'job', 0, 2, 2, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ', '', 'filtered_html'),
('node', 'job', 0, 3, 3, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\r\n\r\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html'),
('node', 'job', 0, 4, 4, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.\r\n\r\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html'),
('node', 'job', 0, 5, 5, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html'),
('node', 'job', 0, 6, 6, 'und', 0, 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.', '', 'filtered_html');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_revision_comment_body`
--

CREATE TABLE `jbqo_field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext DEFAULT NULL,
  `comment_body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_revision_field_employment_type`
--

CREATE TABLE `jbqo_field_revision_field_employment_type` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_employment_type_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (field_employment_type)';

--
-- Dumping data for table `jbqo_field_revision_field_employment_type`
--

INSERT INTO `jbqo_field_revision_field_employment_type` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_employment_type_value`) VALUES
('node', 'job', 0, 2, 2, 'und', 0, '1'),
('node', 'job', 0, 3, 3, 'und', 0, '2'),
('node', 'job', 0, 4, 4, 'und', 0, '3'),
('node', 'job', 0, 5, 5, 'und', 0, '3'),
('node', 'job', 0, 6, 6, 'und', 0, '1');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_revision_field_image`
--

CREATE TABLE `jbqo_field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The `jbqo_file_managed`.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) UNSIGNED DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) UNSIGNED DEFAULT NULL COMMENT 'The height of the image in pixels.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_field_revision_field_tags`
--

CREATE TABLE `jbqo_field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_file_managed`
--

CREATE TABLE `jbqo_file_managed` (
  `fid` int(10) UNSIGNED NOT NULL COMMENT 'File ID.',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'UNIX timestamp for when the file was added.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_file_usage`
--

CREATE TABLE `jbqo_file_usage` (
  `fid` int(10) UNSIGNED NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The primary key of the object using the file.',
  `count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The number of times this file is used by this object.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_filter`
--

CREATE TABLE `jbqo_filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The `jbqo_filter_format`.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob DEFAULT NULL COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

--
-- Dumping data for table `jbqo_filter`
--

INSERT INTO `jbqo_filter` (`format`, `module`, `name`, `weight`, `status`, `settings`) VALUES
('filtered_html', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html', 1, 1, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('filtered_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('full_html', 'filter', 'filter_autop', 1, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('full_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('full_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('plain_text', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('plain_text', 'filter', 'filter_htmlcorrector', 10, 0, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html_escape', 0, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_url', 1, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_filter_format`
--

CREATE TABLE `jbqo_filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'Weight of text format to use when listing.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

--
-- Dumping data for table `jbqo_filter_format`
--

INSERT INTO `jbqo_filter_format` (`format`, `name`, `cache`, `status`, `weight`) VALUES
('filtered_html', 'Filtered HTML', 1, 1, 0),
('full_html', 'Full HTML', 1, 1, 1),
('plain_text', 'Plain text', 1, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_flood`
--

CREATE TABLE `jbqo_flood` (
  `fid` int(11) NOT NULL COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT 0 COMMENT 'Expiration timestamp. Expired events are purged on cron run.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_history`
--

CREATE TABLE `jbqo_history` (
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid that read the `jbqo_node` nid.',
  `nid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node`.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT 0 COMMENT 'The Unix timestamp at which the read occurred.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which `jbqo_users` have read which `jbqo_node`s.';

--
-- Dumping data for table `jbqo_history`
--

INSERT INTO `jbqo_history` (`uid`, `nid`, `timestamp`) VALUES
(1, 1, 1608028765),
(1, 2, 1608040917),
(1, 3, 1608041774),
(1, 4, 1608061783),
(1, 5, 1608106209),
(1, 6, 1608106103);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_image_effects`
--

CREATE TABLE `jbqo_image_effects` (
  `ieid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_image_styles`.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_image_styles`
--

CREATE TABLE `jbqo_image_styles` (
  `isid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_menu_custom`
--

CREATE TABLE `jbqo_menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text DEFAULT NULL COMMENT 'Menu description.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

--
-- Dumping data for table `jbqo_menu_custom`
--

INSERT INTO `jbqo_menu_custom` (`menu_name`, `title`, `description`) VALUES
('devel', 'Development', 'Development link'),
('features', 'Features', 'Menu items for any enabled features.'),
('main-menu', 'Main menu', 'The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),
('management', 'Management', 'The <em>Management</em> menu contains links for administrative tasks.'),
('navigation', 'Navigation', 'The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),
('user-menu', 'User menu', 'The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_menu_links`
--

CREATE TABLE `jbqo_menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) UNSIGNED NOT NULL COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a `jbqo_menu_router`.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in `jbqo_menu_router`.',
  `options` blob DEFAULT NULL COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT 0 COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT 0 COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';

--
-- Dumping data for table `jbqo_menu_links`
--

INSERT INTO `jbqo_menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 1, 0, 'admin', 'admin', 'Administration', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 9, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 2, 0, 'user', 'user', 'User account', 0x613a313a7b733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, -10, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 3, 0, 'comment/%', 'comment/%', 'Comment permalink', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 4, 0, 'filter/tips', 'filter/tips', 'Compose tips', 0x613a303a7b7d, 'system', 1, 0, 1, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 5, 0, 'node/%', 'node/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 6, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 7, 1, 'admin/appearance', 'admin/appearance', 'Appearance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -6, 2, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 8, 1, 'admin/config', 'admin/config', 'Configuration', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32303a2241646d696e69737465722073657474696e67732e223b7d7d, 'system', 0, 0, 1, 0, 0, 2, 0, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 9, 1, 'admin/content', 'admin/content', 'Content', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a2241646d696e697374657220636f6e74656e7420616e6420636f6d6d656e74732e223b7d7d, 'system', 0, 0, 1, 0, -10, 2, 0, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 10, 2, 'user/register', 'user/register', 'Create new account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 10, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 12, 1, 'admin/help', 'admin/help', 'Help', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a225265666572656e636520666f722075736167652c20636f6e66696775726174696f6e2c20616e64206d6f64756c65732e223b7d7d, 'system', 0, 0, 0, 0, 9, 2, 0, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 13, 1, 'admin/index', 'admin/index', 'Index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -18, 2, 0, 1, 13, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 14, 2, 'user/login', 'user/login', 'Log in', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 15, 0, 'user/logout', 'user/logout', 'Log out', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 10, 1, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 16, 1, 'admin/modules', 'admin/modules', 'Modules', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32363a22457874656e6420736974652066756e6374696f6e616c6974792e223b7d7d, 'system', 0, 0, 0, 0, -2, 2, 0, 1, 16, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 17, 0, 'user/%', 'user/%', 'My account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 18, 1, 'admin/people', 'admin/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a224d616e6167652075736572206163636f756e74732c20726f6c65732c20616e64207065726d697373696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -4, 2, 0, 1, 18, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 19, 1, 'admin/reports', 'admin/reports', 'Reports', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a2256696577207265706f7274732c20757064617465732c20616e64206572726f72732e223b7d7d, 'system', 0, 0, 1, 0, 5, 2, 0, 1, 19, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 20, 2, 'user/password', 'user/password', 'Request new password', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 20, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 21, 1, 'admin/structure', 'admin/structure', 'Structure', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a2241646d696e697374657220626c6f636b732c20636f6e74656e742074797065732c206d656e75732c206574632e223b7d7d, 'system', 0, 0, 1, 0, -8, 2, 0, 1, 21, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 22, 1, 'admin/tasks', 'admin/tasks', 'Tasks', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 2, 0, 1, 22, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 23, 0, 'comment/reply/%', 'comment/reply/%', 'Add new comment', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 24, 3, 'comment/%/approve', 'comment/%/approve', 'Approve', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 1, 2, 0, 3, 24, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 25, 4, 'filter/tips/%', 'filter/tips/%', 'Compose tips', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 2, 0, 4, 25, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 26, 3, 'comment/%/delete', 'comment/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 3, 26, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 27, 3, 'comment/%/edit', 'comment/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 3, 27, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 28, 0, 'taxonomy/term/%', 'taxonomy/term/%', 'Taxonomy term', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 28, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 29, 3, 'comment/%/view', 'comment/%/view', 'View comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 3, 29, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 30, 18, 'admin/people/create', 'admin/people/create', 'Add user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 30, 0, 0, 0, 0, 0, 0, 0),
('management', 31, 21, 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37393a22436f6e666967757265207768617420626c6f636b20636f6e74656e74206170706561727320696e20796f75722073697465277320736964656261727320616e64206f7468657220726567696f6e732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 31, 0, 0, 0, 0, 0, 0, 0),
('navigation', 32, 17, 'user/%/cancel', 'user/%/cancel', 'Cancel account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 2, 0, 17, 32, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 33, 9, 'admin/content/comment', 'admin/content/comment', 'Comments', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35393a224c69737420616e642065646974207369746520636f6d6d656e747320616e642074686520636f6d6d656e7420617070726f76616c2071756575652e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 9, 33, 0, 0, 0, 0, 0, 0, 0),
('management', 35, 9, 'admin/content/node', 'admin/content/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 9, 35, 0, 0, 0, 0, 0, 0, 0),
('management', 36, 8, 'admin/config/content', 'admin/config/content', 'Content authoring', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a2253657474696e67732072656c6174656420746f20666f726d617474696e6720616e6420617574686f72696e6720636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 36, 0, 0, 0, 0, 0, 0, 0),
('management', 37, 21, 'admin/structure/types', 'admin/structure/types', 'Content types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a39323a224d616e61676520636f6e74656e742074797065732c20696e636c7564696e672064656661756c74207374617475732c2066726f6e7420706167652070726f6d6f74696f6e2c20636f6d6d656e742073657474696e67732c206574632e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 37, 0, 0, 0, 0, 0, 0, 0),
('navigation', 39, 5, 'node/%/delete', 'node/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 2, 0, 5, 39, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 40, 8, 'admin/config/development', 'admin/config/development', 'Development', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22446576656c6f706d656e7420746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 40, 0, 0, 0, 0, 0, 0, 0),
('navigation', 41, 17, 'user/%/edit', 'user/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 41, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 42, 5, 'node/%/edit', 'node/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 5, 42, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 43, 19, 'admin/reports/fields', 'admin/reports/fields', 'Field list', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224f76657276696577206f66206669656c6473206f6e20616c6c20656e746974792074797065732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 43, 0, 0, 0, 0, 0, 0, 0),
('management', 44, 16, 'admin/modules/list', 'admin/modules/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 16, 44, 0, 0, 0, 0, 0, 0, 0),
('management', 45, 18, 'admin/people/people', 'admin/people/people', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35303a2246696e6420616e64206d616e6167652070656f706c6520696e746572616374696e67207769746820796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 18, 45, 0, 0, 0, 0, 0, 0, 0),
('management', 46, 7, 'admin/appearance/list', 'admin/appearance/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33313a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65223b7d7d, 'system', -1, 0, 0, 0, -1, 3, 0, 1, 7, 46, 0, 0, 0, 0, 0, 0, 0),
('management', 47, 8, 'admin/config/media', 'admin/config/media', 'Media', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31323a224d6564696120746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 47, 0, 0, 0, 0, 0, 0, 0),
('management', 48, 21, 'admin/structure/menu', 'admin/structure/menu', 'Menus', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38363a22416464206e6577206d656e757320746f20796f757220736974652c2065646974206578697374696e67206d656e75732c20616e642072656e616d6520616e642072656f7267616e697a65206d656e75206c696e6b732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 48, 0, 0, 0, 0, 0, 0, 0),
('management', 49, 8, 'admin/config/people', 'admin/config/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32343a22436f6e6669677572652075736572206163636f756e74732e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 49, 0, 0, 0, 0, 0, 0, 0),
('management', 50, 18, 'admin/people/permissions', 'admin/people/permissions', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 50, 0, 0, 0, 0, 0, 0, 0),
('management', 51, 19, 'admin/reports/dblog', 'admin/reports/dblog', 'Recent log messages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a2256696577206576656e74732074686174206861766520726563656e746c79206265656e206c6f676765642e223b7d7d, 'system', 0, 0, 0, 0, -1, 3, 0, 1, 19, 51, 0, 0, 0, 0, 0, 0, 0),
('management', 52, 8, 'admin/config/regional', 'admin/config/regional', 'Regional and language', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a22526567696f6e616c2073657474696e67732c206c6f63616c697a6174696f6e20616e64207472616e736c6174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -5, 3, 0, 1, 8, 52, 0, 0, 0, 0, 0, 0, 0),
('navigation', 53, 5, 'node/%/revisions', 'node/%/revisions', 'Revisions', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 2, 2, 0, 5, 53, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 54, 8, 'admin/config/search', 'admin/config/search', 'Search and metadata', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a224c6f63616c2073697465207365617263682c206d6574616461746120616e642053454f2e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 54, 0, 0, 0, 0, 0, 0, 0),
('management', 55, 7, 'admin/appearance/settings', 'admin/appearance/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a22436f6e6669677572652064656661756c7420616e64207468656d652073706563696669632073657474696e67732e223b7d7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 7, 55, 0, 0, 0, 0, 0, 0, 0),
('management', 56, 19, 'admin/reports/status', 'admin/reports/status', 'Status report', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a22476574206120737461747573207265706f72742061626f757420796f757220736974652773206f7065726174696f6e20616e6420616e792064657465637465642070726f626c656d732e223b7d7d, 'system', 0, 0, 0, 0, -60, 3, 0, 1, 19, 56, 0, 0, 0, 0, 0, 0, 0),
('management', 57, 8, 'admin/config/system', 'admin/config/system', 'System', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33373a2247656e6572616c2073797374656d2072656c6174656420636f6e66696775726174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 57, 0, 0, 0, 0, 0, 0, 0),
('management', 58, 21, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Taxonomy', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a224d616e6167652074616767696e672c2063617465676f72697a6174696f6e2c20616e6420636c617373696669636174696f6e206f6620796f757220636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 58, 0, 0, 0, 0, 0, 0, 0),
('management', 59, 19, 'admin/reports/access-denied', 'admin/reports/access-denied', 'Top \'access denied\' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33353a225669657720276163636573732064656e69656427206572726f7273202834303373292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 59, 0, 0, 0, 0, 0, 0, 0),
('management', 60, 19, 'admin/reports/page-not-found', 'admin/reports/page-not-found', 'Top \'page not found\' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a2256696577202770616765206e6f7420666f756e6427206572726f7273202834303473292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 60, 0, 0, 0, 0, 0, 0, 0),
('management', 61, 16, 'admin/modules/uninstall', 'admin/modules/uninstall', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 16, 61, 0, 0, 0, 0, 0, 0, 0),
('management', 62, 8, 'admin/config/user-interface', 'admin/config/user-interface', 'User interface', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a22546f6f6c73207468617420656e68616e636520746865207573657220696e746572666163652e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 62, 0, 0, 0, 0, 0, 0, 0),
('navigation', 63, 5, 'node/%/view', 'node/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 5, 63, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 64, 17, 'user/%/view', 'user/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 17, 64, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 65, 8, 'admin/config/services', 'admin/config/services', 'Web services', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a22546f6f6c732072656c6174656420746f207765622073657276696365732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 8, 65, 0, 0, 0, 0, 0, 0, 0),
('management', 66, 8, 'admin/config/workflow', 'admin/config/workflow', 'Workflow', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22436f6e74656e7420776f726b666c6f772c20656469746f7269616c20776f726b666c6f7720746f6f6c732e223b7d7d, 'system', 0, 0, 0, 0, 5, 3, 0, 1, 8, 66, 0, 0, 0, 0, 0, 0, 0),
('management', 67, 12, 'admin/help/block', 'admin/help/block', 'block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 67, 0, 0, 0, 0, 0, 0, 0),
('management', 68, 12, 'admin/help/color', 'admin/help/color', 'color', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 68, 0, 0, 0, 0, 0, 0, 0),
('management', 69, 12, 'admin/help/comment', 'admin/help/comment', 'comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 69, 0, 0, 0, 0, 0, 0, 0),
('management', 70, 12, 'admin/help/contextual', 'admin/help/contextual', 'contextual', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 70, 0, 0, 0, 0, 0, 0, 0),
('management', 72, 12, 'admin/help/dblog', 'admin/help/dblog', 'dblog', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 72, 0, 0, 0, 0, 0, 0, 0),
('management', 73, 12, 'admin/help/field', 'admin/help/field', 'field', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 73, 0, 0, 0, 0, 0, 0, 0),
('management', 74, 12, 'admin/help/field_sql_storage', 'admin/help/field_sql_storage', 'field_sql_storage', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 74, 0, 0, 0, 0, 0, 0, 0),
('management', 75, 12, 'admin/help/field_ui', 'admin/help/field_ui', 'field_ui', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 75, 0, 0, 0, 0, 0, 0, 0),
('management', 76, 12, 'admin/help/file', 'admin/help/file', 'file', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 76, 0, 0, 0, 0, 0, 0, 0),
('management', 77, 12, 'admin/help/filter', 'admin/help/filter', 'filter', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 77, 0, 0, 0, 0, 0, 0, 0),
('management', 78, 12, 'admin/help/help', 'admin/help/help', 'help', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 78, 0, 0, 0, 0, 0, 0, 0),
('management', 79, 12, 'admin/help/image', 'admin/help/image', 'image', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 79, 0, 0, 0, 0, 0, 0, 0),
('management', 80, 12, 'admin/help/list', 'admin/help/list', 'list', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 80, 0, 0, 0, 0, 0, 0, 0),
('management', 81, 12, 'admin/help/menu', 'admin/help/menu', 'menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 81, 0, 0, 0, 0, 0, 0, 0),
('management', 82, 12, 'admin/help/node', 'admin/help/node', 'node', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 82, 0, 0, 0, 0, 0, 0, 0),
('management', 83, 12, 'admin/help/options', 'admin/help/options', 'options', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 83, 0, 0, 0, 0, 0, 0, 0),
('management', 84, 12, 'admin/help/system', 'admin/help/system', 'system', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 84, 0, 0, 0, 0, 0, 0, 0),
('management', 85, 12, 'admin/help/taxonomy', 'admin/help/taxonomy', 'taxonomy', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 85, 0, 0, 0, 0, 0, 0, 0),
('management', 86, 12, 'admin/help/text', 'admin/help/text', 'text', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 86, 0, 0, 0, 0, 0, 0, 0),
('management', 87, 12, 'admin/help/user', 'admin/help/user', 'user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 87, 0, 0, 0, 0, 0, 0, 0),
('navigation', 88, 28, 'taxonomy/term/%/edit', 'taxonomy/term/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 2, 0, 28, 88, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 89, 28, 'taxonomy/term/%/view', 'taxonomy/term/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 28, 89, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 90, 58, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 58, 90, 0, 0, 0, 0, 0, 0),
('management', 91, 49, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Account settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130393a22436f6e6669677572652064656661756c74206265686176696f72206f662075736572732c20696e636c7564696e6720726567697374726174696f6e20726571756972656d656e74732c20652d6d61696c732c206669656c64732c20616e6420757365722070696374757265732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 49, 91, 0, 0, 0, 0, 0, 0),
('management', 92, 57, 'admin/config/system/actions', 'admin/config/system/actions', 'Actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 57, 92, 0, 0, 0, 0, 0, 0),
('management', 93, 31, 'admin/structure/block/add', 'admin/structure/block/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 93, 0, 0, 0, 0, 0, 0),
('management', 94, 37, 'admin/structure/types/add', 'admin/structure/types/add', 'Add content type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 37, 94, 0, 0, 0, 0, 0, 0),
('management', 95, 48, 'admin/structure/menu/add', 'admin/structure/menu/add', 'Add menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 48, 95, 0, 0, 0, 0, 0, 0),
('management', 96, 58, 'admin/structure/taxonomy/add', 'admin/structure/taxonomy/add', 'Add vocabulary', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 58, 96, 0, 0, 0, 0, 0, 0),
('management', 97, 55, 'admin/appearance/settings/bartik', 'admin/appearance/settings/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 97, 0, 0, 0, 0, 0, 0),
('management', 98, 54, 'admin/config/search/clean-urls', 'admin/config/search/clean-urls', 'Clean URLs', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22456e61626c65206f722064697361626c6520636c65616e2055524c7320666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 0, 0, 5, 4, 0, 1, 8, 54, 98, 0, 0, 0, 0, 0, 0),
('management', 99, 57, 'admin/config/system/cron', 'admin/config/system/cron', 'Cron', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34303a224d616e616765206175746f6d617469632073697465206d61696e74656e616e6365207461736b732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 57, 99, 0, 0, 0, 0, 0, 0),
('management', 100, 52, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Date and time', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 52, 100, 0, 0, 0, 0, 0, 0),
('management', 101, 19, 'admin/reports/event/%', 'admin/reports/event/%', 'Details', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 101, 0, 0, 0, 0, 0, 0, 0),
('management', 102, 47, 'admin/config/media/file-system', 'admin/config/media/file-system', 'File system', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36383a2254656c6c2044727570616c20776865726520746f2073746f72652075706c6f616465642066696c657320616e6420686f772074686579206172652061636365737365642e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 47, 102, 0, 0, 0, 0, 0, 0),
('management', 103, 55, 'admin/appearance/settings/garland', 'admin/appearance/settings/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 103, 0, 0, 0, 0, 0, 0),
('management', 104, 55, 'admin/appearance/settings/global', 'admin/appearance/settings/global', 'Global settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -1, 4, 0, 1, 7, 55, 104, 0, 0, 0, 0, 0, 0),
('management', 105, 49, 'admin/config/people/ip-blocking', 'admin/config/people/ip-blocking', 'IP address blocking', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224d616e61676520626c6f636b6564204950206164647265737365732e223b7d7d, 'system', 0, 0, 1, 0, 10, 4, 0, 1, 8, 49, 105, 0, 0, 0, 0, 0, 0),
('management', 106, 47, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Image styles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37383a22436f6e666967757265207374796c657320746861742063616e206265207573656420666f7220726573697a696e67206f722061646a757374696e6720696d61676573206f6e20646973706c61792e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 47, 106, 0, 0, 0, 0, 0, 0),
('management', 107, 47, 'admin/config/media/image-toolkit', 'admin/config/media/image-toolkit', 'Image toolkit', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a2243686f6f736520776869636820696d61676520746f6f6c6b697420746f2075736520696620796f75206861766520696e7374616c6c6564206f7074696f6e616c20746f6f6c6b6974732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 47, 107, 0, 0, 0, 0, 0, 0),
('management', 108, 44, 'admin/modules/list/confirm', 'admin/modules/list/confirm', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 44, 108, 0, 0, 0, 0, 0, 0),
('management', 109, 37, 'admin/structure/types/list', 'admin/structure/types/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 37, 109, 0, 0, 0, 0, 0, 0),
('management', 110, 58, 'admin/structure/taxonomy/list', 'admin/structure/taxonomy/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 58, 110, 0, 0, 0, 0, 0, 0),
('management', 111, 48, 'admin/structure/menu/list', 'admin/structure/menu/list', 'List menus', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 48, 111, 0, 0, 0, 0, 0, 0),
('management', 112, 40, 'admin/config/development/logging', 'admin/config/development/logging', 'Logging and errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3135343a2253657474696e677320666f72206c6f6767696e6720616e6420616c65727473206d6f64756c65732e20566172696f7573206d6f64756c65732063616e20726f7574652044727570616c27732073797374656d206576656e747320746f20646966666572656e742064657374696e6174696f6e732c2073756368206173207379736c6f672c2064617461626173652c20656d61696c2c206574632e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 40, 112, 0, 0, 0, 0, 0, 0),
('management', 113, 40, 'admin/config/development/maintenance', 'admin/config/development/maintenance', 'Maintenance mode', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36323a2254616b65207468652073697465206f66666c696e6520666f72206d61696e74656e616e6365206f72206272696e67206974206261636b206f6e6c696e652e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 40, 113, 0, 0, 0, 0, 0, 0),
('management', 114, 40, 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130313a22456e61626c65206f722064697361626c6520706167652063616368696e6720666f7220616e6f6e796d6f757320757365727320616e64207365742043535320616e64204a532062616e647769647468206f7074696d697a6174696f6e206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 40, 114, 0, 0, 0, 0, 0, 0),
('management', 115, 50, 'admin/people/permissions/list', 'admin/people/permissions/list', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, -8, 4, 0, 1, 18, 50, 115, 0, 0, 0, 0, 0, 0),
('management', 116, 33, 'admin/content/comment/new', 'admin/content/comment/new', 'Published comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 9, 33, 116, 0, 0, 0, 0, 0, 0),
('management', 117, 65, 'admin/config/services/rss-publishing', 'admin/config/services/rss-publishing', 'RSS publishing', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3131343a22436f6e666967757265207468652073697465206465736372697074696f6e2c20746865206e756d626572206f66206974656d7320706572206665656420616e6420776865746865722066656564732073686f756c64206265207469746c65732f746561736572732f66756c6c2d746578742e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 65, 117, 0, 0, 0, 0, 0, 0),
('management', 118, 52, 'admin/config/regional/settings', 'admin/config/regional/settings', 'Regional settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35343a2253657474696e677320666f7220746865207369746527732064656661756c742074696d65207a6f6e6520616e6420636f756e7472792e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 52, 118, 0, 0, 0, 0, 0, 0),
('management', 119, 50, 'admin/people/permissions/roles', 'admin/people/permissions/roles', 'Roles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a224c6973742c20656469742c206f7220616464207573657220726f6c65732e223b7d7d, 'system', -1, 0, 1, 0, -5, 4, 0, 1, 18, 50, 119, 0, 0, 0, 0, 0, 0),
('management', 120, 48, 'admin/structure/menu/settings', 'admin/structure/menu/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 5, 4, 0, 1, 21, 48, 120, 0, 0, 0, 0, 0, 0),
('management', 121, 55, 'admin/appearance/settings/seven', 'admin/appearance/settings/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 121, 0, 0, 0, 0, 0, 0),
('management', 122, 57, 'admin/config/system/site-information', 'admin/config/system/site-information', 'Site information', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130343a224368616e67652073697465206e616d652c20652d6d61696c20616464726573732c20736c6f67616e2c2064656661756c742066726f6e7420706167652c20616e64206e756d626572206f6620706f7374732070657220706167652c206572726f722070616765732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 57, 122, 0, 0, 0, 0, 0, 0),
('management', 123, 55, 'admin/appearance/settings/stark', 'admin/appearance/settings/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 55, 123, 0, 0, 0, 0, 0, 0),
('management', 124, 36, 'admin/config/content/formats', 'admin/config/content/formats', 'Text formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3132373a22436f6e66696775726520686f7720636f6e74656e7420696e7075742062792075736572732069732066696c74657265642c20696e636c7564696e6720616c6c6f7765642048544d4c20746167732e20416c736f20616c6c6f777320656e61626c696e67206f66206d6f64756c652d70726f76696465642066696c746572732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 36, 124, 0, 0, 0, 0, 0, 0),
('management', 125, 33, 'admin/content/comment/approval', 'admin/content/comment/approval', 'Unapproved comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 9, 33, 125, 0, 0, 0, 0, 0, 0),
('management', 126, 61, 'admin/modules/uninstall/confirm', 'admin/modules/uninstall/confirm', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 61, 126, 0, 0, 0, 0, 0, 0),
('navigation', 127, 41, 'user/%/edit/account', 'user/%/edit/account', 'Account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 17, 41, 127, 0, 0, 0, 0, 0, 0, 0),
('management', 128, 124, 'admin/config/content/formats/%', 'admin/config/content/formats/%', '', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 36, 124, 128, 0, 0, 0, 0, 0),
('management', 129, 106, 'admin/config/media/image-styles/add', 'admin/config/media/image-styles/add', 'Add style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a224164642061206e657720696d616765207374796c652e223b7d7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 47, 106, 129, 0, 0, 0, 0, 0),
('management', 130, 90, 'admin/structure/taxonomy/%/add', 'admin/structure/taxonomy/%/add', 'Add term', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 58, 90, 130, 0, 0, 0, 0, 0),
('management', 131, 124, 'admin/config/content/formats/add', 'admin/config/content/formats/add', 'Add text format', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 36, 124, 131, 0, 0, 0, 0, 0),
('management', 132, 31, 'admin/structure/block/list/bartik', 'admin/structure/block/list/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 31, 132, 0, 0, 0, 0, 0, 0),
('management', 133, 92, 'admin/config/system/actions/configure', 'admin/config/system/actions/configure', 'Configure an advanced action', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 57, 92, 133, 0, 0, 0, 0, 0),
('management', 134, 48, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Customize menu', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 48, 134, 0, 0, 0, 0, 0, 0),
('management', 135, 90, 'admin/structure/taxonomy/%/edit', 'admin/structure/taxonomy/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 58, 90, 135, 0, 0, 0, 0, 0),
('management', 136, 37, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit content type', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 37, 136, 0, 0, 0, 0, 0, 0),
('management', 137, 100, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time/formats', 'Formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35313a22436f6e66696775726520646973706c617920666f726d617420737472696e677320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -9, 5, 0, 1, 8, 52, 100, 137, 0, 0, 0, 0, 0),
('management', 138, 31, 'admin/structure/block/list/garland', 'admin/structure/block/list/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 138, 0, 0, 0, 0, 0, 0),
('management', 139, 124, 'admin/config/content/formats/list', 'admin/config/content/formats/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 36, 124, 139, 0, 0, 0, 0, 0),
('management', 140, 90, 'admin/structure/taxonomy/%/list', 'admin/structure/taxonomy/%/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 5, 0, 1, 21, 58, 90, 140, 0, 0, 0, 0, 0),
('management', 141, 106, 'admin/config/media/image-styles/list', 'admin/config/media/image-styles/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34323a224c697374207468652063757272656e7420696d616765207374796c6573206f6e2074686520736974652e223b7d7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 47, 106, 141, 0, 0, 0, 0, 0),
('management', 142, 92, 'admin/config/system/actions/manage', 'admin/config/system/actions/manage', 'Manage actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -2, 5, 0, 1, 8, 57, 92, 142, 0, 0, 0, 0, 0),
('management', 143, 91, 'admin/config/people/accounts/settings', 'admin/config/people/accounts/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 49, 91, 143, 0, 0, 0, 0, 0),
('management', 144, 31, 'admin/structure/block/list/seven', 'admin/structure/block/list/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 144, 0, 0, 0, 0, 0, 0),
('management', 145, 31, 'admin/structure/block/list/stark', 'admin/structure/block/list/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 31, 145, 0, 0, 0, 0, 0, 0),
('management', 146, 100, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time/types', 'Types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -10, 5, 0, 1, 8, 52, 100, 146, 0, 0, 0, 0, 0),
('navigation', 147, 53, 'node/%/revisions/%/delete', 'node/%/revisions/%/delete', 'Delete earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 53, 147, 0, 0, 0, 0, 0, 0, 0),
('navigation', 148, 53, 'node/%/revisions/%/revert', 'node/%/revisions/%/revert', 'Revert to earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 53, 148, 0, 0, 0, 0, 0, 0, 0),
('navigation', 149, 53, 'node/%/revisions/%/view', 'node/%/revisions/%/view', 'Revisions', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 53, 149, 0, 0, 0, 0, 0, 0, 0),
('management', 150, 138, 'admin/structure/block/list/garland/add', 'admin/structure/block/list/garland/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 138, 150, 0, 0, 0, 0, 0),
('management', 151, 144, 'admin/structure/block/list/seven/add', 'admin/structure/block/list/seven/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 144, 151, 0, 0, 0, 0, 0),
('management', 152, 145, 'admin/structure/block/list/stark/add', 'admin/structure/block/list/stark/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 145, 152, 0, 0, 0, 0, 0),
('management', 153, 146, 'admin/config/regional/date-time/types/add', 'admin/config/regional/date-time/types/add', 'Add date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22416464206e6577206461746520747970652e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 52, 100, 146, 153, 0, 0, 0, 0),
('management', 154, 137, 'admin/config/regional/date-time/formats/add', 'admin/config/regional/date-time/formats/add', 'Add format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22416c6c6f7720757365727320746f20616464206164646974696f6e616c206461746520666f726d6174732e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 52, 100, 137, 154, 0, 0, 0, 0),
('management', 155, 134, 'admin/structure/menu/manage/%/add', 'admin/structure/menu/manage/%/add', 'Add link', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 48, 134, 155, 0, 0, 0, 0, 0),
('management', 156, 31, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 31, 156, 0, 0, 0, 0, 0, 0),
('navigation', 157, 32, 'user/%/cancel/confirm/%/%', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 17, 32, 157, 0, 0, 0, 0, 0, 0, 0),
('management', 158, 136, 'admin/structure/types/manage/%/delete', 'admin/structure/types/manage/%/delete', 'Delete', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 37, 136, 158, 0, 0, 0, 0, 0),
('management', 159, 105, 'admin/config/people/ip-blocking/delete/%', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 49, 105, 159, 0, 0, 0, 0, 0),
('management', 160, 92, 'admin/config/system/actions/delete/%', 'admin/config/system/actions/delete/%', 'Delete action', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31373a2244656c65746520616e20616374696f6e2e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 57, 92, 160, 0, 0, 0, 0, 0),
('management', 161, 134, 'admin/structure/menu/manage/%/delete', 'admin/structure/menu/manage/%/delete', 'Delete menu', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 48, 134, 161, 0, 0, 0, 0, 0),
('management', 162, 48, 'admin/structure/menu/item/%/delete', 'admin/structure/menu/item/%/delete', 'Delete menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 162, 0, 0, 0, 0, 0, 0),
('management', 163, 119, 'admin/people/permissions/roles/delete/%', 'admin/people/permissions/roles/delete/%', 'Delete role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 50, 119, 163, 0, 0, 0, 0, 0),
('management', 164, 128, 'admin/config/content/formats/%/disable', 'admin/config/content/formats/%/disable', 'Disable text format', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 36, 124, 128, 164, 0, 0, 0, 0),
('management', 165, 136, 'admin/structure/types/manage/%/edit', 'admin/structure/types/manage/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 37, 136, 165, 0, 0, 0, 0, 0),
('management', 166, 134, 'admin/structure/menu/manage/%/edit', 'admin/structure/menu/manage/%/edit', 'Edit menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 48, 134, 166, 0, 0, 0, 0, 0),
('management', 167, 48, 'admin/structure/menu/item/%/edit', 'admin/structure/menu/item/%/edit', 'Edit menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 167, 0, 0, 0, 0, 0, 0),
('management', 168, 119, 'admin/people/permissions/roles/edit/%', 'admin/people/permissions/roles/edit/%', 'Edit role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 50, 119, 168, 0, 0, 0, 0, 0),
('management', 169, 106, 'admin/config/media/image-styles/edit/%', 'admin/config/media/image-styles/edit/%', 'Edit style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22436f6e66696775726520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 47, 106, 169, 0, 0, 0, 0, 0),
('management', 170, 134, 'admin/structure/menu/manage/%/list', 'admin/structure/menu/manage/%/list', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 48, 134, 170, 0, 0, 0, 0, 0),
('management', 171, 48, 'admin/structure/menu/item/%/reset', 'admin/structure/menu/item/%/reset', 'Reset menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 171, 0, 0, 0, 0, 0, 0),
('management', 172, 106, 'admin/config/media/image-styles/delete/%', 'admin/config/media/image-styles/delete/%', 'Delete style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2244656c65746520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 47, 106, 172, 0, 0, 0, 0, 0),
('management', 173, 106, 'admin/config/media/image-styles/revert/%', 'admin/config/media/image-styles/revert/%', 'Revert style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2252657665727420616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 47, 106, 173, 0, 0, 0, 0, 0),
('management', 174, 136, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%/comment/display', 'Comment display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 5, 0, 1, 21, 37, 136, 174, 0, 0, 0, 0, 0),
('management', 175, 136, 'admin/structure/types/manage/%/comment/fields', 'admin/structure/types/manage/%/comment/fields', 'Comment fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 3, 5, 0, 1, 21, 37, 136, 175, 0, 0, 0, 0, 0),
('management', 176, 156, 'admin/structure/block/manage/%/%/configure', 'admin/structure/block/manage/%/%/configure', 'Configure block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 156, 176, 0, 0, 0, 0, 0),
('management', 177, 156, 'admin/structure/block/manage/%/%/delete', 'admin/structure/block/manage/%/%/delete', 'Delete block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 31, 156, 177, 0, 0, 0, 0, 0),
('management', 178, 137, 'admin/config/regional/date-time/formats/%/delete', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34373a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 52, 100, 137, 178, 0, 0, 0, 0),
('management', 179, 146, 'admin/config/regional/date-time/types/%/delete', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520747970652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 52, 100, 146, 179, 0, 0, 0, 0),
('management', 180, 137, 'admin/config/regional/date-time/formats/%/edit', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2065646974206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 52, 100, 137, 180, 0, 0, 0, 0),
('management', 181, 169, 'admin/config/media/image-styles/edit/%/add/%', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224164642061206e65772065666665637420746f2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 47, 106, 169, 181, 0, 0, 0, 0),
('management', 182, 169, 'admin/config/media/image-styles/edit/%/effects/%', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224564697420616e206578697374696e67206566666563742077697468696e2061207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 6, 0, 1, 8, 47, 106, 169, 182, 0, 0, 0, 0),
('management', 183, 182, 'admin/config/media/image-styles/edit/%/effects/%/delete', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a2244656c65746520616e206578697374696e67206566666563742066726f6d2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 7, 0, 1, 8, 47, 106, 169, 182, 183, 0, 0, 0),
('management', 184, 48, 'admin/structure/menu/manage/main-menu', 'admin/structure/menu/manage/%', 'Main menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 184, 0, 0, 0, 0, 0, 0),
('management', 185, 48, 'admin/structure/menu/manage/management', 'admin/structure/menu/manage/%', 'Management', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 185, 0, 0, 0, 0, 0, 0),
('management', 186, 48, 'admin/structure/menu/manage/navigation', 'admin/structure/menu/manage/%', 'Navigation', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 186, 0, 0, 0, 0, 0, 0),
('management', 187, 48, 'admin/structure/menu/manage/user-menu', 'admin/structure/menu/manage/%', 'User menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 48, 187, 0, 0, 0, 0, 0, 0),
('navigation', 188, 0, 'search', 'search', 'Search', 0x613a303a7b7d, 'system', 1, 0, 0, 0, 0, 1, 0, 188, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 189, 188, 'search/node', 'search/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 188, 189, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 190, 188, 'search/user', 'search/user', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 188, 190, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 191, 189, 'search/node/%', 'search/node/%', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 188, 189, 191, 0, 0, 0, 0, 0, 0, 0),
('navigation', 192, 17, 'user/%/shortcuts', 'user/%/shortcuts', 'Shortcuts', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 192, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 193, 19, 'admin/reports/search', 'admin/reports/search', 'Top search phrases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2256696577206d6f737420706f70756c61722073656172636820706872617365732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 193, 0, 0, 0, 0, 0, 0, 0),
('navigation', 194, 190, 'search/user/%', 'search/user/%', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 188, 190, 194, 0, 0, 0, 0, 0, 0, 0),
('management', 195, 12, 'admin/help/number', 'admin/help/number', 'number', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 195, 0, 0, 0, 0, 0, 0, 0),
('management', 197, 12, 'admin/help/path', 'admin/help/path', 'path', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 197, 0, 0, 0, 0, 0, 0, 0),
('management', 198, 12, 'admin/help/rdf', 'admin/help/rdf', 'rdf', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 198, 0, 0, 0, 0, 0, 0, 0),
('management', 199, 12, 'admin/help/search', 'admin/help/search', 'search', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 199, 0, 0, 0, 0, 0, 0, 0),
('management', 200, 12, 'admin/help/shortcut', 'admin/help/shortcut', 'shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 200, 0, 0, 0, 0, 0, 0, 0),
('management', 201, 54, 'admin/config/search/settings', 'admin/config/search/settings', 'Search settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a22436f6e6669677572652072656c6576616e63652073657474696e677320666f722073656172636820616e64206f7468657220696e646578696e67206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 54, 201, 0, 0, 0, 0, 0, 0),
('management', 202, 62, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Shortcuts', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32393a2241646420616e64206d6f646966792073686f727463757420736574732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 62, 202, 0, 0, 0, 0, 0, 0),
('management', 203, 54, 'admin/config/search/path', 'admin/config/search/path', 'URL aliases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a224368616e676520796f7572207369746527732055524c20706174687320627920616c696173696e67207468656d2e223b7d7d, 'system', 0, 0, 1, 0, -5, 4, 0, 1, 8, 54, 203, 0, 0, 0, 0, 0, 0),
('management', 204, 203, 'admin/config/search/path/add', 'admin/config/search/path/add', 'Add alias', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 54, 203, 204, 0, 0, 0, 0, 0),
('management', 205, 202, 'admin/config/user-interface/shortcut/add-set', 'admin/config/user-interface/shortcut/add-set', 'Add shortcut set', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 62, 202, 205, 0, 0, 0, 0, 0),
('management', 206, 201, 'admin/config/search/settings/reindex', 'admin/config/search/settings/reindex', 'Clear index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 54, 201, 206, 0, 0, 0, 0, 0),
('management', 207, 202, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 62, 202, 207, 0, 0, 0, 0, 0),
('management', 208, 203, 'admin/config/search/path/list', 'admin/config/search/path/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 54, 203, 208, 0, 0, 0, 0, 0),
('management', 209, 207, 'admin/config/user-interface/shortcut/%/add-link', 'admin/config/user-interface/shortcut/%/add-link', 'Add shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 207, 209, 0, 0, 0, 0),
('management', 210, 203, 'admin/config/search/path/delete/%', 'admin/config/search/path/delete/%', 'Delete alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 54, 203, 210, 0, 0, 0, 0, 0),
('management', 211, 207, 'admin/config/user-interface/shortcut/%/delete', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 207, 211, 0, 0, 0, 0);
INSERT INTO `jbqo_menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 212, 203, 'admin/config/search/path/edit/%', 'admin/config/search/path/edit/%', 'Edit alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 54, 203, 212, 0, 0, 0, 0, 0),
('management', 213, 207, 'admin/config/user-interface/shortcut/%/edit', 'admin/config/user-interface/shortcut/%/edit', 'Edit set name', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 6, 0, 1, 8, 62, 202, 207, 213, 0, 0, 0, 0),
('management', 214, 202, 'admin/config/user-interface/shortcut/link/%', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 62, 202, 214, 0, 0, 0, 0, 0),
('management', 215, 207, 'admin/config/user-interface/shortcut/%/links', 'admin/config/user-interface/shortcut/%/links', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 207, 215, 0, 0, 0, 0),
('management', 216, 214, 'admin/config/user-interface/shortcut/link/%/delete', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 62, 202, 214, 216, 0, 0, 0, 0),
('shortcut-set-1', 217, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -20, 1, 0, 217, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('shortcut-set-1', 218, 0, 'admin/content', 'admin/content', 'Find content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -19, 1, 0, 218, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 219, 0, '<front>', '', 'Home', 0x613a303a7b7d, 'menu', 0, 1, 0, 0, 0, 1, 0, 219, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 220, 6, 'node/add/article', 'node/add/article', 'Article', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38393a22557365203c656d3e61727469636c65733c2f656d3e20666f722074696d652d73656e73697469766520636f6e74656e74206c696b65206e6577732c2070726573732072656c6561736573206f7220626c6f6720706f7374732e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 220, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 221, 6, 'node/add/page', 'node/add/page', 'Basic page', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37373a22557365203c656d3e62617369632070616765733c2f656d3e20666f7220796f75722073746174696320636f6e74656e742c207375636820617320616e202741626f75742075732720706167652e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 221, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 222, 12, 'admin/help/toolbar', 'admin/help/toolbar', 'toolbar', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 222, 0, 0, 0, 0, 0, 0, 0),
('management', 299, 19, 'admin/reports/updates', 'admin/reports/updates', 'Available updates', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38323a22476574206120737461747573207265706f72742061626f757420617661696c61626c65207570646174657320666f7220796f757220696e7374616c6c6564206d6f64756c657320616e64207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -50, 3, 0, 1, 19, 299, 0, 0, 0, 0, 0, 0, 0),
('management', 300, 16, 'admin/modules/install', 'admin/modules/install', 'Install new module', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 3, 0, 1, 16, 300, 0, 0, 0, 0, 0, 0, 0),
('management', 301, 7, 'admin/appearance/install', 'admin/appearance/install', 'Install new theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 3, 0, 1, 7, 301, 0, 0, 0, 0, 0, 0, 0),
('management', 302, 16, 'admin/modules/update', 'admin/modules/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 1, 16, 302, 0, 0, 0, 0, 0, 0, 0),
('management', 303, 7, 'admin/appearance/update', 'admin/appearance/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 1, 7, 303, 0, 0, 0, 0, 0, 0, 0),
('management', 304, 12, 'admin/help/update', 'admin/help/update', 'update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 304, 0, 0, 0, 0, 0, 0, 0),
('management', 305, 299, 'admin/reports/updates/install', 'admin/reports/updates/install', 'Install new module or theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 4, 0, 1, 19, 299, 305, 0, 0, 0, 0, 0, 0),
('management', 306, 299, 'admin/reports/updates/update', 'admin/reports/updates/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 4, 0, 1, 19, 299, 306, 0, 0, 0, 0, 0, 0),
('management', 307, 299, 'admin/reports/updates/list', 'admin/reports/updates/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 19, 299, 307, 0, 0, 0, 0, 0, 0),
('management', 308, 299, 'admin/reports/updates/settings', 'admin/reports/updates/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 50, 4, 0, 1, 19, 299, 308, 0, 0, 0, 0, 0, 0),
('management', 309, 90, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 58, 90, 309, 0, 0, 0, 0, 0),
('management', 310, 91, 'admin/config/people/accounts/display', 'admin/config/people/accounts/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 49, 91, 310, 0, 0, 0, 0, 0),
('management', 311, 90, 'admin/structure/taxonomy/%/fields', 'admin/structure/taxonomy/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 58, 90, 311, 0, 0, 0, 0, 0),
('management', 312, 91, 'admin/config/people/accounts/fields', 'admin/config/people/accounts/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 8, 49, 91, 312, 0, 0, 0, 0, 0),
('management', 313, 309, 'admin/structure/taxonomy/%/display/default', 'admin/structure/taxonomy/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 58, 90, 309, 313, 0, 0, 0, 0),
('management', 314, 310, 'admin/config/people/accounts/display/default', 'admin/config/people/accounts/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 49, 91, 310, 314, 0, 0, 0, 0),
('management', 315, 136, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 37, 136, 315, 0, 0, 0, 0, 0),
('management', 316, 136, 'admin/structure/types/manage/%/fields', 'admin/structure/types/manage/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 37, 136, 316, 0, 0, 0, 0, 0),
('management', 317, 309, 'admin/structure/taxonomy/%/display/full', 'admin/structure/taxonomy/%/display/full', 'Taxonomy term page', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 58, 90, 309, 317, 0, 0, 0, 0),
('management', 318, 310, 'admin/config/people/accounts/display/full', 'admin/config/people/accounts/display/full', 'User account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 49, 91, 310, 318, 0, 0, 0, 0),
('management', 319, 311, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 58, 90, 311, 319, 0, 0, 0, 0),
('management', 320, 312, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 49, 91, 312, 320, 0, 0, 0, 0),
('management', 321, 315, 'admin/structure/types/manage/%/display/default', 'admin/structure/types/manage/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 37, 136, 315, 321, 0, 0, 0, 0),
('management', 322, 315, 'admin/structure/types/manage/%/display/full', 'admin/structure/types/manage/%/display/full', 'Full content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 315, 322, 0, 0, 0, 0),
('management', 323, 315, 'admin/structure/types/manage/%/display/rss', 'admin/structure/types/manage/%/display/rss', 'RSS', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 6, 0, 1, 21, 37, 136, 315, 323, 0, 0, 0, 0),
('management', 324, 315, 'admin/structure/types/manage/%/display/search_index', 'admin/structure/types/manage/%/display/search_index', 'Search index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 3, 6, 0, 1, 21, 37, 136, 315, 324, 0, 0, 0, 0),
('management', 325, 315, 'admin/structure/types/manage/%/display/search_result', 'admin/structure/types/manage/%/display/search_result', 'Search result highlighting input', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 6, 0, 1, 21, 37, 136, 315, 325, 0, 0, 0, 0),
('management', 326, 315, 'admin/structure/types/manage/%/display/teaser', 'admin/structure/types/manage/%/display/teaser', 'Teaser', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 6, 0, 1, 21, 37, 136, 315, 326, 0, 0, 0, 0),
('management', 327, 316, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 316, 327, 0, 0, 0, 0),
('management', 328, 319, 'admin/structure/taxonomy/%/fields/%/delete', 'admin/structure/taxonomy/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 58, 90, 311, 319, 328, 0, 0, 0),
('management', 329, 319, 'admin/structure/taxonomy/%/fields/%/edit', 'admin/structure/taxonomy/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 58, 90, 311, 319, 329, 0, 0, 0),
('management', 330, 319, 'admin/structure/taxonomy/%/fields/%/field-settings', 'admin/structure/taxonomy/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 58, 90, 311, 319, 330, 0, 0, 0),
('management', 331, 319, 'admin/structure/taxonomy/%/fields/%/widget-type', 'admin/structure/taxonomy/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 58, 90, 311, 319, 331, 0, 0, 0),
('management', 332, 320, 'admin/config/people/accounts/fields/%/delete', 'admin/config/people/accounts/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 8, 49, 91, 312, 320, 332, 0, 0, 0),
('management', 333, 320, 'admin/config/people/accounts/fields/%/edit', 'admin/config/people/accounts/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 49, 91, 312, 320, 333, 0, 0, 0),
('management', 334, 320, 'admin/config/people/accounts/fields/%/field-settings', 'admin/config/people/accounts/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 49, 91, 312, 320, 334, 0, 0, 0),
('management', 335, 320, 'admin/config/people/accounts/fields/%/widget-type', 'admin/config/people/accounts/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 49, 91, 312, 320, 335, 0, 0, 0),
('management', 336, 174, 'admin/structure/types/manage/%/comment/display/default', 'admin/structure/types/manage/%/comment/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 37, 136, 174, 336, 0, 0, 0, 0),
('management', 337, 174, 'admin/structure/types/manage/%/comment/display/full', 'admin/structure/types/manage/%/comment/display/full', 'Full comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 174, 337, 0, 0, 0, 0),
('management', 338, 175, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 37, 136, 175, 338, 0, 0, 0, 0),
('management', 339, 327, 'admin/structure/types/manage/%/fields/%/delete', 'admin/structure/types/manage/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 37, 136, 316, 327, 339, 0, 0, 0),
('management', 340, 327, 'admin/structure/types/manage/%/fields/%/edit', 'admin/structure/types/manage/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 316, 327, 340, 0, 0, 0),
('management', 341, 327, 'admin/structure/types/manage/%/fields/%/field-settings', 'admin/structure/types/manage/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 316, 327, 341, 0, 0, 0),
('management', 342, 327, 'admin/structure/types/manage/%/fields/%/widget-type', 'admin/structure/types/manage/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 316, 327, 342, 0, 0, 0),
('management', 343, 338, 'admin/structure/types/manage/%/comment/fields/%/delete', 'admin/structure/types/manage/%/comment/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 37, 136, 175, 338, 343, 0, 0, 0),
('management', 344, 338, 'admin/structure/types/manage/%/comment/fields/%/edit', 'admin/structure/types/manage/%/comment/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 175, 338, 344, 0, 0, 0),
('management', 345, 338, 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 175, 338, 345, 0, 0, 0),
('management', 346, 338, 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 37, 136, 175, 338, 346, 0, 0, 0),
('navigation', 347, 6, 'node/add/job', 'node/add/job', 'Job', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31373a22437265617465206a6f6220656e74697479223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 347, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 348, 21, 'admin/structure/views', 'admin/structure/views', 'Views', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33353a224d616e61676520637573746f6d697a6564206c69737473206f6620636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 348, 0, 0, 0, 0, 0, 0, 0),
('management', 349, 19, 'admin/reports/views-plugins', 'admin/reports/views-plugins', 'Views plugins', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a224f76657276696577206f6620706c7567696e73207573656420696e20616c6c2076696577732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 349, 0, 0, 0, 0, 0, 0, 0),
('management', 350, 12, 'admin/help/views', 'admin/help/views', 'views', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 350, 0, 0, 0, 0, 0, 0, 0),
('management', 351, 12, 'admin/help/views_ui', 'admin/help/views_ui', 'views_ui', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 351, 0, 0, 0, 0, 0, 0, 0),
('management', 352, 348, 'admin/structure/views/add', 'admin/structure/views/add', 'Add new view', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 348, 352, 0, 0, 0, 0, 0, 0),
('management', 353, 348, 'admin/structure/views/add-template', 'admin/structure/views/add-template', 'Add view from template', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 348, 353, 0, 0, 0, 0, 0, 0),
('management', 354, 348, 'admin/structure/views/import', 'admin/structure/views/import', 'Import', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 348, 354, 0, 0, 0, 0, 0, 0),
('management', 355, 348, 'admin/structure/views/list', 'admin/structure/views/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 348, 355, 0, 0, 0, 0, 0, 0),
('management', 356, 43, 'admin/reports/fields/list', 'admin/reports/fields/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 19, 43, 356, 0, 0, 0, 0, 0, 0),
('management', 357, 348, 'admin/structure/views/settings', 'admin/structure/views/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 348, 357, 0, 0, 0, 0, 0, 0),
('management', 358, 43, 'admin/reports/fields/views-fields', 'admin/reports/fields/views-fields', 'Used in views', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33373a224f76657276696577206f66206669656c6473207573656420696e20616c6c2076696577732e223b7d7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 19, 43, 358, 0, 0, 0, 0, 0, 0),
('management', 359, 357, 'admin/structure/views/settings/advanced', 'admin/structure/views/settings/advanced', 'Advanced', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 21, 348, 357, 359, 0, 0, 0, 0, 0),
('management', 360, 357, 'admin/structure/views/settings/basic', 'admin/structure/views/settings/basic', 'Basic', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 357, 360, 0, 0, 0, 0, 0),
('management', 361, 348, 'admin/structure/views/view/%', 'admin/structure/views/view/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 348, 361, 0, 0, 0, 0, 0, 0),
('management', 362, 361, 'admin/structure/views/view/%/break-lock', 'admin/structure/views/view/%/break-lock', 'Break lock', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 361, 362, 0, 0, 0, 0, 0),
('management', 363, 361, 'admin/structure/views/view/%/edit', 'admin/structure/views/view/%/edit', 'Edit view', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 348, 361, 363, 0, 0, 0, 0, 0),
('management', 364, 361, 'admin/structure/views/view/%/clone', 'admin/structure/views/view/%/clone', 'Clone', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 361, 364, 0, 0, 0, 0, 0),
('management', 365, 361, 'admin/structure/views/view/%/delete', 'admin/structure/views/view/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 361, 365, 0, 0, 0, 0, 0),
('management', 366, 361, 'admin/structure/views/view/%/export', 'admin/structure/views/view/%/export', 'Export', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 361, 366, 0, 0, 0, 0, 0),
('management', 367, 361, 'admin/structure/views/view/%/revert', 'admin/structure/views/view/%/revert', 'Revert', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 361, 367, 0, 0, 0, 0, 0),
('management', 368, 361, 'admin/structure/views/view/%/preview/%', 'admin/structure/views/view/%/preview/%', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 348, 361, 368, 0, 0, 0, 0, 0),
('management', 369, 348, 'admin/structure/views/ajax/preview/%/%', 'admin/structure/views/ajax/preview/%/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 348, 369, 0, 0, 0, 0, 0, 0),
('management', 370, 348, 'admin/structure/views/nojs/preview/%/%', 'admin/structure/views/nojs/preview/%/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 348, 370, 0, 0, 0, 0, 0, 0),
('devel', 371, 0, 'devel/settings', 'devel/settings', 'Devel settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3136383a2248656c7065722066756e6374696f6e732c2070616765732c20616e6420626c6f636b7320746f206173736973742044727570616c20646576656c6f706572732e2054686520646576656c20626c6f636b732063616e206265206d616e616765642076696120746865203c6120687265663d222f61646d696e2f7374727563747572652f626c6f636b223e626c6f636b2061646d696e697374726174696f6e3c2f613e20706167652e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 371, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 372, 0, 'devel/php', 'devel/php', 'Execute PHP Code', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32313a224578656375746520736f6d652050485020636f6465223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 372, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 373, 0, 'devel/reference', 'devel/reference', 'Function reference', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37333a22566965772061206c697374206f662063757272656e746c7920646566696e656420757365722066756e6374696f6e73207769746820646f63756d656e746174696f6e206c696e6b732e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 373, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 374, 0, 'devel/elements', 'devel/elements', 'Hook_elements()', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35313a2256696577207468652061637469766520666f726d2f72656e64657220656c656d656e747320666f72207468697320736974652e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 374, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 375, 0, 'devel/phpinfo', 'devel/phpinfo', 'PHPinfo()', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a225669657720796f75722073657276657227732050485020636f6e66696775726174696f6e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 375, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 376, 0, 'devel/reinstall', 'devel/reinstall', 'Reinstall modules', 0x613a323a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2252756e20686f6f6b5f756e696e7374616c6c282920616e64207468656e20686f6f6b5f696e7374616c6c282920666f72206120676976656e206d6f64756c652e223b7d733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 376, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 377, 0, 'devel/run-cron', 'devel/run-cron', 'Run cron', 0x613a313a7b733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 377, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 378, 0, 'devel/session', 'devel/session', 'Session viewer', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33313a224c6973742074686520636f6e74656e7473206f6620245f53455353494f4e2e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 378, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 379, 0, 'devel/variable', 'devel/variable', 'Variable editor', 0x613a323a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33313a224564697420616e642064656c6574652073697465207661726961626c65732e223b7d733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 379, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 380, 0, 'devel/cache/clear', 'devel/cache/clear', 'Clear cache', 0x613a323a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130303a22436c656172207468652043535320636163686520616e6420616c6c206461746162617365206361636865207461626c65732077686963682073746f726520706167652c206e6f64652c207468656d6520616e64207661726961626c65206361636865732e223b7d733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 380, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 381, 3, 'comment/%/devel', 'comment/%/devel', 'Devel', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 2, 0, 3, 381, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 382, 5, 'node/%/devel', 'node/%/devel', 'Devel', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 2, 0, 5, 382, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 383, 17, 'user/%/devel', 'user/%/devel', 'Devel', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 2, 0, 17, 383, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 384, 0, 'devel/entity/info', 'devel/entity/info', 'Entity info', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a225669657720656e7469747920696e666f726d6174696f6e206163726f7373207468652077686f6c6520736974652e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 384, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 385, 0, 'devel/field/info', 'devel/field/info', 'Field info', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a2256696577206669656c647320696e666f726d6174696f6e206163726f7373207468652077686f6c6520736974652e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 385, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 386, 0, 'devel/menu/item', 'devel/menu/item', 'Menu item', 0x613a323a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a2244657461696c732061626f7574206120676976656e206d656e75206974656d2e223b7d733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 386, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 387, 0, 'devel/menu/reset', 'devel/menu/reset', 'Rebuild menus', 0x613a323a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3131333a2252656275696c64206d656e75206261736564206f6e20686f6f6b5f6d656e75282920616e642072657665727420616e7920637573746f6d206368616e6765732e20416c6c206d656e75206974656d732072657475726e20746f2074686569722064656661756c742073657474696e67732e223b7d733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 387, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('devel', 388, 0, 'devel/theme/registry', 'devel/theme/registry', 'Theme registry', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36333a22566965772061206c697374206f6620617661696c61626c65207468656d652066756e6374696f6e73206163726f7373207468652077686f6c6520736974652e223b7d7d, 'system', 0, 0, 0, 0, 0, 1, 0, 388, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 389, 12, 'admin/help/devel', 'admin/help/devel', 'devel', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 389, 0, 0, 0, 0, 0, 0, 0),
('navigation', 390, 28, 'taxonomy/term/%/devel', 'taxonomy/term/%/devel', 'Devel', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 2, 0, 28, 390, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 391, 40, 'admin/config/development/devel', 'admin/config/development/devel', 'Devel settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3136383a2248656c7065722066756e6374696f6e732c2070616765732c20616e6420626c6f636b7320746f206173736973742044727570616c20646576656c6f706572732e2054686520646576656c20626c6f636b732063616e206265206d616e616765642076696120746865203c6120687265663d222f61646d696e2f7374727563747572652f626c6f636b223e626c6f636b2061646d696e697374726174696f6e3c2f613e20706167652e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 40, 391, 0, 0, 0, 0, 0, 0),
('navigation', 392, 381, 'comment/%/devel/load', 'comment/%/devel/load', 'Load', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 3, 381, 392, 0, 0, 0, 0, 0, 0, 0),
('navigation', 393, 382, 'node/%/devel/load', 'node/%/devel/load', 'Load', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 5, 382, 393, 0, 0, 0, 0, 0, 0, 0),
('navigation', 394, 383, 'user/%/devel/load', 'user/%/devel/load', 'Load', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 17, 383, 394, 0, 0, 0, 0, 0, 0, 0),
('navigation', 395, 381, 'comment/%/devel/render', 'comment/%/devel/render', 'Render', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 3, 0, 3, 381, 395, 0, 0, 0, 0, 0, 0, 0),
('navigation', 396, 382, 'node/%/devel/render', 'node/%/devel/render', 'Render', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 3, 0, 5, 382, 396, 0, 0, 0, 0, 0, 0, 0),
('navigation', 397, 383, 'user/%/devel/render', 'user/%/devel/render', 'Render', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 3, 0, 17, 383, 397, 0, 0, 0, 0, 0, 0, 0),
('navigation', 398, 390, 'taxonomy/term/%/devel/load', 'taxonomy/term/%/devel/load', 'Load', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 28, 390, 398, 0, 0, 0, 0, 0, 0, 0),
('navigation', 399, 390, 'taxonomy/term/%/devel/render', 'taxonomy/term/%/devel/render', 'Render', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 100, 3, 0, 28, 390, 399, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 400, 0, 'jobs', 'jobs', 'Jobs', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 401, 21, 'admin/structure/features', 'admin/structure/features', 'Features', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31363a224d616e6167652066656174757265732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 21, 401, 0, 0, 0, 0, 0, 0, 0),
('management', 402, 12, 'admin/help/features', 'admin/help/features', 'features', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 402, 0, 0, 0, 0, 0, 0, 0),
('management', 403, 401, 'admin/structure/features/create', 'admin/structure/features/create', 'Create feature', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32313a224372656174652061206e657720666561747572652e223b7d7d, 'system', -1, 0, 0, 0, 10, 4, 0, 1, 21, 401, 403, 0, 0, 0, 0, 0, 0),
('management', 404, 401, 'admin/structure/features/manage', 'admin/structure/features/manage', 'Manage', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a22456e61626c6520616e642064697361626c652066656174757265732e223b7d7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 401, 404, 0, 0, 0, 0, 0, 0),
('management', 405, 401, 'admin/structure/features/settings', 'admin/structure/features/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34323a2241646a7573742073657474696e677320666f72207573696e67206665617475726573206d6f64756c652e223b7d7d, 'system', -1, 0, 0, 0, 11, 4, 0, 1, 21, 401, 405, 0, 0, 0, 0, 0, 0),
('management', 406, 401, 'admin/structure/features/%/view', 'admin/structure/features/%/view', 'View', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a22446973706c617920636f6d706f6e656e7473206f66206120666561747572652e223b7d7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 401, 406, 0, 0, 0, 0, 0, 0),
('management', 407, 401, 'admin/structure/features/%/recreate', 'admin/structure/features/%/recreate', 'Recreate', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32393a22526563726561746520616e206578697374696e6720666561747572652e223b7d7d, 'system', -1, 0, 0, 0, 11, 4, 0, 1, 21, 401, 407, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_menu_router`
--

CREATE TABLE `jbqo_menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob DEFAULT NULL COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob DEFAULT NULL COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT 0 COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT 0 COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT 0 COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT 0 COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext DEFAULT NULL COMMENT 'The file to include for this element, usually the page callback function lives in this file.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';

--
-- Dumping data for table `jbqo_menu_router`
--

INSERT INTO `jbqo_menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'admin', 'Administration', 't', '', '', 'a:0:{}', 6, '', '', 9, 'modules/system/system.admin.inc'),
('admin/appearance', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_themes_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/appearance', 'Appearance', 't', '', '', 'a:0:{}', 6, 'Select and configure your themes.', 'left', -6, 'modules/system/system.admin.inc'),
('admin/appearance/default', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_default', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/default', 'Set default theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/disable', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_disable', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/disable', 'Disable theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/enable', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_theme_enable', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/appearance/enable', 'Enable theme', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/install', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a227570646174655f6d616e616765725f696e7374616c6c5f666f726d223b693a313b733a353a227468656d65223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Install new theme', 't', '', '', 'a:0:{}', 388, '', '', 25, 'modules/update/update.manager.inc'),
('admin/appearance/list', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'system_themes_page', 0x613a303a7b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'List', 't', '', '', 'a:0:{}', 140, 'Select and configure your theme', '', -1, 'modules/system/system.admin.inc'),
('admin/appearance/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Settings', 't', '', '', 'a:0:{}', 132, 'Configure default and theme specific settings.', '', 20, 'modules/system/system.admin.inc'),
('admin/appearance/settings/bartik', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a31373a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a363a2262617274696b223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Bartik', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/garland', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a373a226761726c616e64223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Garland', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/global', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e6973746572207468656d6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Global settings', 't', '', '', 'a:0:{}', 140, '', '', -1, 'modules/system/system.admin.inc'),
('admin/appearance/settings/seven', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a353a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a353a22736576656e223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Seven', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/settings/stark', '', '', '_system_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31373a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32313a2273797374656d5f7468656d655f73657474696e6773223b693a313b733a353a22737461726b223b7d, '', 15, 4, 1, 'admin/appearance/settings', 'admin/appearance', 'Stark', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/system/system.admin.inc'),
('admin/appearance/update', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a227570646174655f6d616e616765725f7570646174655f666f726d223b693a313b733a353a227468656d65223b7d, '', 7, 3, 1, 'admin/appearance', 'admin/appearance', 'Update', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/update/update.manager.inc'),
('admin/compact', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_compact_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/compact', 'Compact mode', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_config_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/config', 'Configuration', 't', '', '', 'a:0:{}', 6, 'Administer settings.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/content', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/content', 'Content authoring', 't', '', '', 'a:0:{}', 6, 'Settings related to formatting and authoring content.', 'left', -15, 'modules/system/system.admin.inc'),
('admin/config/content/formats', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2266696c7465725f61646d696e5f6f76657276696577223b7d, '', 15, 4, 0, '', 'admin/config/content/formats', 'Text formats', 't', '', '', 'a:0:{}', 6, 'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%', 0x613a313a7b693a343b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'filter_admin_format_page', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'admin/config/content/formats/%', '', 'filter_admin_format_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/%/disable', 0x613a313a7b693a343b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', '_filter_disable_format_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2266696c7465725f61646d696e5f64697361626c65223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/config/content/formats/%/disable', 'Disable text format', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/add', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'filter_admin_format_page', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/content/formats', 'admin/config/content/formats', 'Add text format', 't', '', '', 'a:0:{}', 388, '', '', 1, 'modules/filter/filter.admin.inc'),
('admin/config/content/formats/list', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e69737465722066696c74657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2266696c7465725f61646d696e5f6f76657276696577223b7d, '', 31, 5, 1, 'admin/config/content/formats', 'admin/config/content/formats', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/filter/filter.admin.inc'),
('admin/config/development', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/development', 'Development', 't', '', '', 'a:0:{}', 6, 'Development tools.', 'right', -10, 'modules/system/system.admin.inc'),
('admin/config/development/devel', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22646576656c5f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/devel', 'Devel settings', 't', '', '', 'a:0:{}', 6, 'Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href=\"/admin/structure/block\">block administration</a> page.', '', 0, 'sites/all/modules/contrib/devel/devel.admin.inc'),
('admin/config/development/logging', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32333a2273797374656d5f6c6f6767696e675f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/logging', 'Logging and errors', 't', '', '', 'a:0:{}', 6, 'Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.', '', -15, 'modules/system/system.admin.inc'),
('admin/config/development/maintenance', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32383a2273797374656d5f736974655f6d61696e74656e616e63655f6d6f6465223b7d, '', 15, 4, 0, '', 'admin/config/development/maintenance', 'Maintenance mode', 't', '', '', 'a:0:{}', 6, 'Take the site offline for maintenance or bring it back online.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/development/performance', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32373a2273797374656d5f706572666f726d616e63655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/development/performance', 'Performance', 't', '', '', 'a:0:{}', 6, 'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/media', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/media', 'Media', 't', '', '', 'a:0:{}', 6, 'Media tools.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/media/file-system', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32373a2273797374656d5f66696c655f73797374656d5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/media/file-system', 'File system', 't', '', '', 'a:0:{}', 6, 'Tell Drupal where to store uploaded files and how they are accessed.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/media/image-styles', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'image_style_list', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/media/image-styles', 'Image styles', 't', '', '', 'a:0:{}', 6, 'Configure styles that can be used for resizing or adjusting images on display.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/add', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22696d6167655f7374796c655f6164645f666f726d223b7d, '', 31, 5, 1, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Add style', 't', '', '', 'a:0:{}', 388, 'Add a new image style.', '', 2, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/delete/%', 0x613a313a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b4e3b693a313b733a313a2231223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a22696d6167655f7374796c655f64656c6574655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/delete/%', 'Delete style', 't', '', '', 'a:0:{}', 6, 'Delete an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%', 0x613a313a7b693a353b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31363a22696d6167655f7374796c655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/edit/%', 'Edit style', 't', '', '', 'a:0:{}', 6, 'Configure an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/add/%', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a313a7b693a303b693a353b7d7d693a373b613a313a7b733a32383a22696d6167655f6566666563745f646566696e6974696f6e5f6c6f6164223b613a313a7b693a303b693a353b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22696d6167655f6566666563745f666f726d223b693a313b693a353b693a323b693a373b7d, '', 250, 8, 0, '', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 't', '', '', 'a:0:{}', 6, 'Add a new effect to a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d693a373b613a313a7b733a31373a22696d6167655f6566666563745f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31373a22696d6167655f6566666563745f666f726d223b693a313b693a353b693a323b693a373b7d, '', 250, 8, 0, '', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 't', '', '', 'a:0:{}', 6, 'Edit an existing effect within a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/edit/%/effects/%/delete', 0x613a323a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d693a373b613a313a7b733a31373a22696d6167655f6566666563745f6c6f6164223b613a323a7b693a303b693a353b693a313b733a313a2233223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32343a22696d6167655f6566666563745f64656c6574655f666f726d223b693a313b693a353b693a323b693a373b7d, '', 501, 9, 0, '', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 't', '', '', 'a:0:{}', 6, 'Delete an existing effect from a style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/list', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'image_style_list', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'List', 't', '', '', 'a:0:{}', 140, 'List the current image styles on the site.', '', 1, 'modules/image/image.admin.inc'),
('admin/config/media/image-styles/revert/%', 0x613a313a7b693a353b613a313a7b733a31363a22696d6167655f7374796c655f6c6f6164223b613a323a7b693a303b4e3b693a313b733a313a2232223b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a32333a2261646d696e697374657220696d616765207374796c6573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a22696d6167655f7374796c655f7265766572745f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/media/image-styles/revert/%', 'Revert style', 't', '', '', 'a:0:{}', 6, 'Revert an image style.', '', 0, 'modules/image/image.admin.inc'),
('admin/config/media/image-toolkit', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32393a2273797374656d5f696d6167655f746f6f6c6b69745f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/media/image-toolkit', 'Image toolkit', 't', '', '', 'a:0:{}', 6, 'Choose which image toolkit to use if you have installed optional toolkits.', '', 20, 'modules/system/system.admin.inc'),
('admin/config/people', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/people', 'People', 't', '', '', 'a:0:{}', 6, 'Configure user accounts.', 'left', -20, 'modules/system/system.admin.inc'),
('admin/config/people/accounts', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22757365725f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/people/accounts', 'Account settings', 't', '', '', 'a:0:{}', 6, 'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.', '', -10, 'modules/user/user.admin.inc'),
('admin/config/people/accounts/display', '', '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a373a2264656661756c74223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/default', '', '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a373a2264656661756c74223b7d, '', 63, 6, 1, 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/display/full', '', '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b693a333b733a343a2266756c6c223b7d, '', 63, 6, 1, 'admin/config/people/accounts/display', 'admin/config/people/accounts', 'User account', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields', '', '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a343a2275736572223b693a323b733a343a2275736572223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/people/accounts/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/delete', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/edit', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/field-settings', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/fields/%/widget-type', 0x613a313a7b693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a2275736572223b693a313b733a343a2275736572223b693a323b733a313a2230223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a353b7d, '', 125, 7, 1, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/config/people/accounts/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22757365725f61646d696e5f73657474696e6773223b7d, '', 31, 5, 1, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Settings', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/user/user.admin.inc'),
('admin/config/people/ip-blocking', '', '', 'user_access', 0x613a313a7b693a303b733a31383a22626c6f636b20495020616464726573736573223b7d, 'system_ip_blocking', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/people/ip-blocking', 'IP address blocking', 't', '', '', 'a:0:{}', 6, 'Manage blocked IP addresses.', '', 10, 'modules/system/system.admin.inc'),
('admin/config/people/ip-blocking/delete/%', 0x613a313a7b693a353b733a31353a22626c6f636b65645f69705f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a22626c6f636b20495020616464726573736573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a2273797374656d5f69705f626c6f636b696e675f64656c657465223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/regional', 'Regional and language', 't', '', '', 'a:0:{}', 6, 'Regional settings, localization and translation.', 'left', -5, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f646174655f74696d655f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/regional/date-time', 'Date and time', 't', '', '', 'a:0:{}', 6, 'Configure display formats for date and time.', '', -15, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_date_time_formats', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Formats', 't', '', '', 'a:0:{}', 132, 'Configure display format strings for date and time.', '', -9, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/delete', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33303a2273797374656d5f646174655f64656c6574655f666f726d61745f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 't', '', '', 'a:0:{}', 6, 'Allow users to delete a configured date format.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/%/edit', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33343a2273797374656d5f636f6e6669677572655f646174655f666f726d6174735f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 't', '', '', 'a:0:{}', 6, 'Allow users to edit a configured date format.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/add', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33343a2273797374656d5f636f6e6669677572655f646174655f666f726d6174735f666f726d223b7d, '', 63, 6, 1, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time', 'Add format', 't', '', '', 'a:0:{}', 388, 'Allow users to add additional date formats.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/formats/lookup', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_date_time_lookup', 0x613a303a7b7d, '', 63, 6, 0, '', 'admin/config/regional/date-time/formats/lookup', 'Date and time lookup', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f646174655f74696d655f73657474696e6773223b7d, '', 31, 5, 1, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Types', 't', '', '', 'a:0:{}', 140, 'Configure display formats for date and time.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/%/delete', 0x613a313a7b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33353a2273797374656d5f64656c6574655f646174655f666f726d61745f747970655f666f726d223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 't', '', '', 'a:0:{}', 6, 'Allow users to delete a configured date type.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/regional/date-time/types/add', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2273797374656d5f6164645f646174655f666f726d61745f747970655f666f726d223b7d, '', 63, 6, 1, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time', 'Add date type', 't', '', '', 'a:0:{}', 388, 'Add new date type.', '', -10, 'modules/system/system.admin.inc'),
('admin/config/regional/settings', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f726567696f6e616c5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/regional/settings', 'Regional settings', 't', '', '', 'a:0:{}', 6, 'Settings for the site\'s default time zone and country.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/search', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/search', 'Search and metadata', 't', '', '', 'a:0:{}', 6, 'Local site search, metadata and SEO.', 'left', -10, 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f636c65616e5f75726c5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/search/clean-urls', 'Clean URLs', 't', '', '', 'a:0:{}', 6, 'Enable or disable clean URLs for your site.', '', 5, 'modules/system/system.admin.inc'),
('admin/config/search/clean-urls/check', '', '', '1', 0x613a303a7b7d, 'drupal_json_output', 0x613a313a7b693a303b613a313a7b733a363a22737461747573223b623a313b7d7d, '', 31, 5, 0, '', 'admin/config/search/clean-urls/check', 'Clean URL check', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/search/path', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_overview', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/search/path', 'URL aliases', 't', '', '', 'a:0:{}', 6, 'Change your site\'s URL paths by aliasing them.', '', -5, 'modules/path/path.admin.inc'),
('admin/config/search/path/add', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_edit', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/search/path', 'admin/config/search/path', 'Add alias', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/delete/%', 0x613a313a7b693a353b733a393a22706174685f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a22706174685f61646d696e5f64656c6574655f636f6e6669726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/search/path/delete/%', 'Delete alias', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/edit/%', 0x613a313a7b693a353b733a393a22706174685f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_edit', 0x613a313a7b693a303b693a353b7d, '', 62, 6, 0, '', 'admin/config/search/path/edit/%', 'Edit alias', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/path/path.admin.inc'),
('admin/config/search/path/list', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e69737465722075726c20616c6961736573223b7d, 'path_admin_overview', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/search/path', 'admin/config/search/path', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/path/path.admin.inc'),
('admin/config/search/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220736561726368223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a227365617263685f61646d696e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/search/settings', 'Search settings', 't', '', '', 'a:0:{}', 6, 'Configure relevance settings for search and other indexing options.', '', -10, 'modules/search/search.admin.inc');
INSERT INTO `jbqo_menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/config/search/settings/reindex', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220736561726368223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a227365617263685f7265696e6465785f636f6e6669726d223b7d, '', 31, 5, 0, '', 'admin/config/search/settings/reindex', 'Clear index', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/search/search.admin.inc'),
('admin/config/services', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/services', 'Web services', 't', '', '', 'a:0:{}', 6, 'Tools related to web services.', 'right', 0, 'modules/system/system.admin.inc'),
('admin/config/services/rss-publishing', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32353a2273797374656d5f7273735f66656564735f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/services/rss-publishing', 'RSS publishing', 't', '', '', 'a:0:{}', 6, 'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/system', 'System', 't', '', '', 'a:0:{}', 6, 'General system related configuration.', 'right', -20, 'modules/system/system.admin.inc'),
('admin/config/system/actions', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_manage', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/system/actions', 'Actions', 't', '', '', 'a:0:{}', 6, 'Manage the actions defined for your site.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f616374696f6e735f636f6e666967757265223b7d, '', 31, 5, 0, '', 'admin/config/system/actions/configure', 'Configure an advanced action', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/delete/%', 0x613a313a7b693a353b733a31323a22616374696f6e735f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a2273797374656d5f616374696f6e735f64656c6574655f666f726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/system/actions/delete/%', 'Delete action', 't', '', '', 'a:0:{}', 6, 'Delete an action.', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/actions/manage', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_manage', 0x613a303a7b7d, '', 31, 5, 1, 'admin/config/system/actions', 'admin/config/system/actions', 'Manage actions', 't', '', '', 'a:0:{}', 140, 'Manage the actions defined for your site.', '', -2, 'modules/system/system.admin.inc'),
('admin/config/system/actions/orphan', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e697374657220616374696f6e73223b7d, 'system_actions_remove_orphans', 0x613a303a7b7d, '', 31, 5, 0, '', 'admin/config/system/actions/orphan', 'Remove orphans', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/config/system/cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a2273797374656d5f63726f6e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/system/cron', 'Cron', 't', '', '', 'a:0:{}', 6, 'Manage automatic site maintenance tasks.', '', 20, 'modules/system/system.admin.inc'),
('admin/config/system/site-information', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2273797374656d5f736974655f696e666f726d6174696f6e5f73657474696e6773223b7d, '', 15, 4, 0, '', 'admin/config/system/site-information', 'Site information', 't', '', '', 'a:0:{}', 6, 'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.', '', -20, 'modules/system/system.admin.inc'),
('admin/config/user-interface', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/user-interface', 'User interface', 't', '', '', 'a:0:{}', 6, 'Tools that enhance the user interface.', 'right', -15, 'modules/system/system.admin.inc'),
('admin/config/user-interface/shortcut', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261646d696e69737465722073686f727463757473223b7d, 'shortcut_set_admin', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/config/user-interface/shortcut', 'Shortcuts', 't', '', '', 'a:0:{}', 6, 'Add and modify shortcut sets.', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f637573746f6d697a65223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 'shortcut_set_title_callback', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a2273686f72746375745f6c696e6b5f616464223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Add shortcut', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/add-link-inline', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'shortcut_link_add_inline', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/config/user-interface/shortcut/%/add-link-inline', 'Add shortcut', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/delete', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_delete_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a2273686f72746375745f7365745f64656c6574655f666f726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/edit', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f656469745f666f726d223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit set name', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/%/links', 0x613a313a7b693a343b733a31373a2273686f72746375745f7365745f6c6f6164223b7d, '', 'shortcut_set_edit_access', 0x613a313a7b693a303b693a343b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32323a2273686f72746375745f7365745f637573746f6d697a65223b693a313b693a343b7d, '', 61, 6, 1, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'List links', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/add-set', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261646d696e69737465722073686f727463757473223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32313a2273686f72746375745f7365745f6164645f666f726d223b7d, '', 31, 5, 1, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Add shortcut set', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%', 0x613a313a7b693a353b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'shortcut_link_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a2273686f72746375745f6c696e6b5f65646974223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/user-interface/shortcut/link/%/delete', 0x613a313a7b693a353b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'shortcut_link_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2273686f72746375745f6c696e6b5f64656c657465223b693a313b693a353b7d, '', 125, 7, 0, '', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('admin/config/workflow', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/config/workflow', 'Workflow', 't', '', '', 'a:0:{}', 6, 'Content workflow, editorial workflow tools.', 'right', 5, 'modules/system/system.admin.inc'),
('admin/content', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261636365737320636f6e74656e74206f76657276696577223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a226e6f64655f61646d696e5f636f6e74656e74223b7d, '', 3, 2, 0, '', 'admin/content', 'Content', 't', '', '', 'a:0:{}', 6, 'Administer content and comments.', '', -10, 'modules/node/node.admin.inc'),
('admin/content/comment', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a303a7b7d, '', 7, 3, 1, 'admin/content', 'admin/content', 'Comments', 't', '', '', 'a:0:{}', 134, 'List and edit site comments and the comment approval queue.', '', 0, 'modules/comment/comment.admin.inc'),
('admin/content/comment/approval', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a313a7b693a303b733a383a22617070726f76616c223b7d, '', 15, 4, 1, 'admin/content/comment', 'admin/content', 'Unapproved comments', 'comment_count_unpublished', '', '', 'a:0:{}', 132, '', '', 0, 'modules/comment/comment.admin.inc'),
('admin/content/comment/new', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_admin', 0x613a303a7b7d, '', 15, 4, 1, 'admin/content/comment', 'admin/content', 'Published comments', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/comment/comment.admin.inc'),
('admin/content/node', '', '', 'user_access', 0x613a313a7b693a303b733a32333a2261636365737320636f6e74656e74206f76657276696577223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a226e6f64655f61646d696e5f636f6e74656e74223b7d, '', 7, 3, 1, 'admin/content', 'admin/content', 'Content', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/node/node.admin.inc'),
('admin/help', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_main', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/help', 'Help', 't', '', '', 'a:0:{}', 6, 'Reference for usage, configuration, and modules.', '', 9, 'modules/help/help.admin.inc'),
('admin/help/block', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/block', 'block', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/color', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/color', 'color', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/comment', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/comment', 'comment', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/contextual', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/contextual', 'contextual', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/dblog', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/dblog', 'dblog', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/devel', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/devel', 'devel', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/features', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/features', 'features', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field', 'field', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field_sql_storage', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field_sql_storage', 'field_sql_storage', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/field_ui', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/field_ui', 'field_ui', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/file', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/file', 'file', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/filter', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/filter', 'filter', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/help', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/help', 'help', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/image', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/image', 'image', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/list', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/list', 'list', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/menu', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/menu', 'menu', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/node', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/node', 'node', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/number', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/number', 'number', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/options', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/options', 'options', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/path', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/path', 'path', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/rdf', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/rdf', 'rdf', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/search', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/search', 'search', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/shortcut', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/shortcut', 'shortcut', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/system', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/system', 'system', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/taxonomy', 'taxonomy', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/text', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/text', 'text', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/toolbar', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/toolbar', 'toolbar', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/update', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/update', 'update', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/user', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/user', 'user', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/views', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/views', 'views', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/help/views_ui', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'help_page', 0x613a313a7b693a303b693a323b7d, '', 7, 3, 0, '', 'admin/help/views_ui', 'views_ui', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/help/help.admin.inc'),
('admin/index', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_index', 0x613a303a7b7d, '', 3, 2, 1, 'admin', 'admin', 'Index', 't', '', '', 'a:0:{}', 132, '', '', -18, 'modules/system/system.admin.inc'),
('admin/modules', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 3, 2, 0, '', 'admin/modules', 'Modules', 't', '', '', 'a:0:{}', 6, 'Extend site functionality.', '', -2, 'modules/system/system.admin.inc'),
('admin/modules/install', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a227570646174655f6d616e616765725f696e7374616c6c5f666f726d223b693a313b733a363a226d6f64756c65223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Install new module', 't', '', '', 'a:0:{}', 388, '', '', 25, 'modules/update/update.manager.inc'),
('admin/modules/list', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/list/confirm', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a2273797374656d5f6d6f64756c6573223b7d, '', 15, 4, 0, '', 'admin/modules/list/confirm', 'List', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/uninstall', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f6d6f64756c65735f756e696e7374616c6c223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Uninstall', 't', '', '', 'a:0:{}', 132, '', '', 20, 'modules/system/system.admin.inc'),
('admin/modules/uninstall/confirm', '', '', 'user_access', 0x613a313a7b693a303b733a31383a2261646d696e6973746572206d6f64756c6573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a2273797374656d5f6d6f64756c65735f756e696e7374616c6c223b7d, '', 15, 4, 0, '', 'admin/modules/uninstall/confirm', 'Uninstall', 't', '', '', 'a:0:{}', 4, '', '', 0, 'modules/system/system.admin.inc'),
('admin/modules/update', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a227570646174655f6d616e616765725f7570646174655f666f726d223b693a313b733a363a226d6f64756c65223b7d, '', 7, 3, 1, 'admin/modules', 'admin/modules', 'Update', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/update/update.manager.inc'),
('admin/people', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a343a226c697374223b7d, '', 3, 2, 0, '', 'admin/people', 'People', 't', '', '', 'a:0:{}', 6, 'Manage user accounts, roles, and permissions.', 'left', -4, 'modules/user/user.admin.inc'),
('admin/people/create', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a363a22637265617465223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'Add user', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/user/user.admin.inc'),
('admin/people/people', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207573657273223b7d, 'user_admin', 0x613a313a7b693a303b733a343a226c697374223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'List', 't', '', '', 'a:0:{}', 140, 'Find and manage people interacting with your site.', '', -10, 'modules/user/user.admin.inc'),
('admin/people/permissions', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a22757365725f61646d696e5f7065726d697373696f6e73223b7d, '', 7, 3, 1, 'admin/people', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', 132, 'Determine access to features by selecting permissions for roles.', '', 0, 'modules/user/user.admin.inc'),
('admin/people/permissions/list', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a22757365725f61646d696e5f7065726d697373696f6e73223b7d, '', 15, 4, 1, 'admin/people/permissions', 'admin/people', 'Permissions', 't', '', '', 'a:0:{}', 140, 'Determine access to features by selecting permissions for roles.', '', -8, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles', '', '', 'user_access', 0x613a313a7b693a303b733a32323a2261646d696e6973746572207065726d697373696f6e73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31363a22757365725f61646d696e5f726f6c6573223b7d, '', 15, 4, 1, 'admin/people/permissions', 'admin/people', 'Roles', 't', '', '', 'a:0:{}', 132, 'List, edit, or add user roles.', '', -5, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/delete/%', 0x613a313a7b693a353b733a31343a22757365725f726f6c655f6c6f6164223b7d, '', 'user_role_edit_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a33303a22757365725f61646d696e5f726f6c655f64656c6574655f636f6e6669726d223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/people/permissions/roles/delete/%', 'Delete role', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.admin.inc'),
('admin/people/permissions/roles/edit/%', 0x613a313a7b693a353b733a31343a22757365725f726f6c655f6c6f6164223b7d, '', 'user_role_edit_access', 0x613a313a7b693a303b693a353b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31353a22757365725f61646d696e5f726f6c65223b693a313b693a353b7d, '', 62, 6, 0, '', 'admin/people/permissions/roles/edit/%', 'Edit role', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.admin.inc'),
('admin/reports', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/reports', 'Reports', 't', '', '', 'a:0:{}', 6, 'View reports, updates, and errors.', 'left', 5, 'modules/system/system.admin.inc'),
('admin/reports/access-denied', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a31333a226163636573732064656e696564223b7d, '', 7, 3, 0, '', 'admin/reports/access-denied', 'Top \'access denied\' errors', 't', '', '', 'a:0:{}', 6, 'View \'access denied\' errors (403s).', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/dblog', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_overview', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/dblog', 'Recent log messages', 't', '', '', 'a:0:{}', 6, 'View events that have recently been logged.', '', -1, 'modules/dblog/dblog.admin.inc'),
('admin/reports/event/%', 0x613a313a7b693a333b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_event', 0x613a313a7b693a303b693a333b7d, '', 14, 4, 0, '', 'admin/reports/event/%', 'Details', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/fields', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'field_ui_fields_list', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/fields', 'Field list', 't', '', '', 'a:0:{}', 6, 'Overview of fields on all entity types.', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/reports/fields/list', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'field_ui_fields_list', 0x613a303a7b7d, '', 15, 4, 1, 'admin/reports/fields', 'admin/reports/fields', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/reports/fields/views-fields', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_field_list', 0x613a303a7b7d, '', 15, 4, 1, 'admin/reports/fields', 'admin/reports/fields', 'Used in views', 't', '', '', 'a:0:{}', 132, 'Overview of fields used in all views.', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/reports/page-not-found', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a31343a2270616765206e6f7420666f756e64223b7d, '', 7, 3, 0, '', 'admin/reports/page-not-found', 'Top \'page not found\' errors', 't', '', '', 'a:0:{}', 6, 'View \'page not found\' errors (404s).', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/search', '', '', 'user_access', 0x613a313a7b693a303b733a31393a226163636573732073697465207265706f727473223b7d, 'dblog_top', 0x613a313a7b693a303b733a363a22736561726368223b7d, '', 7, 3, 0, '', 'admin/reports/search', 'Top search phrases', 't', '', '', 'a:0:{}', 6, 'View most popular search phrases.', '', 0, 'modules/dblog/dblog.admin.inc'),
('admin/reports/status', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_status', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/status', 'Status report', 't', '', '', 'a:0:{}', 6, 'Get a status report about your site\'s operation and any detected problems.', '', -60, 'modules/system/system.admin.inc'),
('admin/reports/status/php', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_php', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/status/php', 'PHP', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/reports/status/rebuild', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a226e6f64655f636f6e6669677572655f72656275696c645f636f6e6669726d223b7d, '', 15, 4, 0, '', 'admin/reports/status/rebuild', 'Rebuild permissions', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/node/node.admin.inc'),
('admin/reports/status/run-cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_run_cron', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/status/run-cron', 'Run cron', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('admin/reports/updates', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'update_status', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/updates', 'Available updates', 't', '', '', 'a:0:{}', 6, 'Get a status report about available updates for your installed modules and themes.', '', -50, 'modules/update/update.report.inc'),
('admin/reports/updates/check', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'update_manual_status', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/reports/updates/check', 'Manual update check', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/update/update.fetch.inc'),
('admin/reports/updates/install', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a227570646174655f6d616e616765725f696e7374616c6c5f666f726d223b693a313b733a363a227265706f7274223b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'Install new module or theme', 't', '', '', 'a:0:{}', 388, '', '', 25, 'modules/update/update.manager.inc'),
('admin/reports/updates/list', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'update_status', 0x613a303a7b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'List', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/update/update.report.inc'),
('admin/reports/updates/settings', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31353a227570646174655f73657474696e6773223b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'Settings', 't', '', '', 'a:0:{}', 132, '', '', 50, 'modules/update/update.settings.inc'),
('admin/reports/updates/update', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a227570646174655f6d616e616765725f7570646174655f666f726d223b693a313b733a363a227265706f7274223b7d, '', 15, 4, 1, 'admin/reports/updates', 'admin/reports/updates', 'Update', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/update/update.manager.inc'),
('admin/reports/views-plugins', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_plugin_list', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/reports/views-plugins', 'Views plugins', 't', '', '', 'a:0:{}', 6, 'Overview of plugins used in all views.', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'admin/structure', 'Structure', 't', '', '', 'a:0:{}', 6, 'Administer blocks, content types, menus, etc.', 'right', -8, 'modules/system/system.admin.inc'),
('admin/structure/block', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'block_admin_display', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 7, 3, 0, '', 'admin/structure/block', 'Blocks', 't', '', '', 'a:0:{}', 6, 'Configure what block content appears in your site\'s sidebars and other regions.', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 15, 4, 1, 'admin/structure/block', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/bartik', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a31373a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/bartik', 'Bartik', 't', '', '_block_custom_theme', 'a:1:{i:0;s:6:\"bartik\";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/garland', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a373a226761726c616e64223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/garland', 'Garland', 't', '', '_block_custom_theme', 'a:1:{i:0;s:7:\"garland\";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/demo/seven', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a353a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/seven', 'Seven', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:\"seven\";}', 0, '', '', 0, 'modules/block/block.admin.inc');
INSERT INTO `jbqo_menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/structure/block/demo/stark', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31373a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_demo', 0x613a313a7b693a303b733a353a22737461726b223b7d, '', 31, 5, 0, '', 'admin/structure/block/demo/stark', 'Stark', 't', '', '_block_custom_theme', 'a:1:{i:0;s:5:\"stark\";}', 0, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/bartik', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32353a227468656d65732f62617274696b2f62617274696b2e696e666f223b733a343a226e616d65223b733a363a2262617274696b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a31373a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a363a2262617274696b223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Bartik', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32373a227468656d65732f6761726c616e642f6761726c616e642e696e666f223b733a343a226e616d65223b733a373a226761726c616e64223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a373a226761726c616e64223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Garland', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/garland/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/garland', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f736576656e2f736576656e2e696e666f223b733a343a226e616d65223b733a353a22736576656e223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2231223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31383a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a353a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22736576656e223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Seven', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/seven/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/seven', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark', '', '', '_block_themes_access', 0x613a313a7b693a303b4f3a383a22737464436c617373223a31323a7b733a383a2266696c656e616d65223b733a32333a227468656d65732f737461726b2f737461726b2e696e666f223b733a343a226e616d65223b733a353a22737461726b223b733a343a2274797065223b733a353a227468656d65223b733a353a226f776e6572223b733a34353a227468656d65732f656e67696e65732f70687074656d706c6174652f70687074656d706c6174652e656e67696e65223b733a363a22737461747573223b733a313a2230223b733a393a22626f6f747374726170223b733a313a2230223b733a31343a22736368656d615f76657273696f6e223b733a323a222d31223b733a363a22776569676874223b733a313a2230223b733a343a22696e666f223b613a31373a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d733a363a22707265666978223b733a31313a2270687074656d706c617465223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b7d7d, 'block_admin_display', 0x613a313a7b693a303b733a353a22737461726b223b7d, '', 31, 5, 1, 'admin/structure/block', 'admin/structure/block', 'Stark', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/list/stark/add', '', '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22626c6f636b5f6164645f626c6f636b5f666f726d223b7d, '', 63, 6, 1, 'admin/structure/block/list/stark', 'admin/structure/block', 'Add block', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32313a22626c6f636b5f61646d696e5f636f6e666967757265223b693a313b693a343b693a323b693a353b7d, '', 60, 6, 0, '', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/configure', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32313a22626c6f636b5f61646d696e5f636f6e666967757265223b693a313b693a343b693a323b693a353b7d, '', 121, 7, 2, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/block/manage/%/%/delete', 0x613a323a7b693a343b4e3b693a353b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31373a2261646d696e697374657220626c6f636b73223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a32353a22626c6f636b5f637573746f6d5f626c6f636b5f64656c657465223b693a313b693a343b693a323b693a353b7d, '', 121, 7, 0, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Delete block', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/block/block.admin.inc'),
('admin/structure/features', '', '', 'user_access', 0x613a313a7b693a303b733a31353a226d616e616765206665617475726573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a2266656174757265735f61646d696e5f666f726d223b7d, '', 7, 3, 0, '', 'admin/structure/features', 'Features', 't', '', '', 'a:0:{}', 6, 'Manage features.', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/%', 0x613a313a7b693a333b613a313a7b733a31323a22666561747572655f6c6f6164223b613a313a7b693a303b623a313b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a2266656174757265735f61646d696e5f636f6d706f6e656e7473223b693a313b693a333b7d, '', 14, 4, 0, '', 'admin/structure/features/%', '', 'features_get_feature_title', 'a:1:{i:0;i:3;}', '', 'a:0:{}', 0, 'Display components of a feature.', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/%/lock', 0x613a313a7b693a333b613a313a7b733a31323a22666561747572655f6c6f6164223b613a313a7b693a303b623a313b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31353a226d616e616765206665617475726573223b7d, 'features_admin_lock', 0x613a333a7b693a303b693a333b693a313b693a353b693a323b693a363b7d, '', 29, 5, 0, '', 'admin/structure/features/%/lock', 'Lock', 't', '', '', 'a:0:{}', 0, 'Lock a feature or components.', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/%/recreate', 0x613a313a7b693a333b613a313a7b733a31323a22666561747572655f6c6f6164223b613a313a7b693a303b623a313b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32303a2266656174757265735f6578706f72745f666f726d223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/features/%', 'admin/structure/features/%', 'Recreate', 't', '', '', 'a:0:{}', 132, 'Recreate an existing feature.', '', 11, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/%/status', 0x613a313a7b693a333b613a313a7b733a31323a22666561747572655f6c6f6164223b613a313a7b693a303b623a313b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'features_feature_status', 0x613a313a7b693a303b693a333b7d, '', 29, 5, 0, '', 'admin/structure/features/%/status', 'Status', 't', '', '', 'a:0:{}', 0, 'Javascript status call back.', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/%/view', 0x613a313a7b693a333b613a313a7b733a31323a22666561747572655f6c6f6164223b613a313a7b693a303b623a313b7d7d7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a2266656174757265735f61646d696e5f636f6d706f6e656e7473223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/features/%', 'admin/structure/features/%', 'View', 't', '', '', 'a:0:{}', 140, 'Display components of a feature.', '', -10, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/cleanup', '', '', 'user_access', 0x613a313a7b693a303b733a31353a226d616e616765206665617475726573223b7d, 'features_cleanup', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/structure/features/cleanup', 'Cleanup', 't', '', '', 'a:0:{}', 0, 'Clear cache after enabling/disabling a feature.', '', 1, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/create', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a2266656174757265735f6578706f72745f666f726d223b7d, '', 15, 4, 1, 'admin/structure/features', 'admin/structure/features', 'Create feature', 't', '', '', 'a:0:{}', 132, 'Create a new feature.', '', 10, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/manage', '', '', 'user_access', 0x613a313a7b693a303b733a31353a226d616e616765206665617475726573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a2266656174757265735f61646d696e5f666f726d223b7d, '', 15, 4, 1, 'admin/structure/features', 'admin/structure/features', 'Manage', 't', '', '', 'a:0:{}', 140, 'Enable and disable features.', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/features/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32323a2266656174757265735f73657474696e67735f666f726d223b7d, '', 15, 4, 1, 'admin/structure/features', 'admin/structure/features', 'Settings', 't', '', '', 'a:0:{}', 132, 'Adjust settings for using features module.', '', 11, 'sites/all/modules/contrib/features/features.admin.inc'),
('admin/structure/menu', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_overview_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/structure/menu', 'Menus', 't', '', '', 'a:0:{}', 6, 'Add new menus to your site, edit existing menus, and rename and reorganize menu links.', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/add', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226d656e755f656469745f6d656e75223b693a313b733a333a22616464223b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'Add menu', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/delete', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_item_delete_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/delete', 'Delete menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/edit', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31343a226d656e755f656469745f6974656d223b693a313b733a343a2265646974223b693a323b693a343b693a333b4e3b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/edit', 'Edit menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/item/%/reset', 0x613a313a7b693a343b733a31343a226d656e755f6c696e6b5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a226d656e755f72657365745f6974656d5f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/item/%/reset', 'Reset menu link', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/list', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_overview_page', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'List menus', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a226d656e755f6f766572766965775f666f726d223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/structure/menu/manage/%', 'Customize menu', 'menu_overview_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/add', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31343a226d656e755f656469745f6974656d223b693a313b733a333a22616464223b693a323b4e3b693a333b693a343b7d, '', 61, 6, 1, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Add link', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/delete', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_delete_menu_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 0, '', 'admin/structure/menu/manage/%/delete', 'Delete menu', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/edit', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31343a226d656e755f656469745f6d656e75223b693a313b733a343a2265646974223b693a323b693a343b7d, '', 61, 6, 3, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Edit menu', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/manage/%/list', 0x613a313a7b693a343b733a393a226d656e755f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31383a226d656e755f6f766572766965775f666f726d223b693a313b693a343b7d, '', 61, 6, 3, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'List links', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/menu/menu.admin.inc'),
('admin/structure/menu/parents', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'menu_parent_options_js', 0x613a303a7b7d, '', 15, 4, 0, '', 'admin/structure/menu/parents', 'Parent menu items', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('admin/structure/menu/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31353a2261646d696e6973746572206d656e75223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a226d656e755f636f6e666967757265223b7d, '', 15, 4, 1, 'admin/structure/menu', 'admin/structure/menu', 'Settings', 't', '', '', 'a:0:{}', 132, '', '', 5, 'modules/menu/menu.admin.inc'),
('admin/structure/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a227461786f6e6f6d795f6f766572766965775f766f636162756c6172696573223b7d, '', 7, 3, 0, '', 'admin/structure/taxonomy', 'Taxonomy', 't', '', '', 'a:0:{}', 6, 'Manage tagging, categorization, and classification of your content.', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a227461786f6e6f6d795f6f766572766965775f7465726d73223b693a313b693a333b7d, '', 14, 4, 0, '', 'admin/structure/taxonomy/%', '', 'entity_label', 'a:2:{i:0;s:19:\"taxonomy_vocabulary\";i:1;i:3;}', '', 'a:0:{}', 6, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/add', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31383a227461786f6e6f6d795f666f726d5f7465726d223b693a313b613a303a7b7d693a323b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Add term', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/display', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a373a2264656661756c74223b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/default', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a373a2264656661756c74223b7d, '', 59, 6, 1, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/display/full', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b693a333b733a343a2266756c6c223b7d, '', 59, 6, 1, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%', 'Taxonomy term page', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/edit', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a227461786f6e6f6d795f666f726d5f766f636162756c617279223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', -10, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/%/fields', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a31333a227461786f6e6f6d795f7465726d223b693a323b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 58, 6, 0, '', 'admin/structure/taxonomy/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:5;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/delete', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/edit', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/field-settings', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/fields/%/widget-type', 0x613a323a7b693a333b613a313a7b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d693a353b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a333b693a323b733a313a2233223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a353b7d, '', 117, 7, 1, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/taxonomy/%/list', 0x613a313a7b693a333b733a33373a227461786f6e6f6d795f766f636162756c6172795f6d616368696e655f6e616d655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32333a227461786f6e6f6d795f6f766572766965775f7465726d73223b693a313b693a333b7d, '', 29, 5, 1, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', 'List', 't', '', '', 'a:0:{}', 140, '', '', -20, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/add', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32343a227461786f6e6f6d795f666f726d5f766f636162756c617279223b7d, '', 15, 4, 1, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Add vocabulary', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/taxonomy/list', '', '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572207461786f6e6f6d79223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33303a227461786f6e6f6d795f6f766572766965775f766f636162756c6172696573223b7d, '', 15, 4, 1, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/taxonomy/taxonomy.admin.inc'),
('admin/structure/types', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'node_overview_types', 0x613a303a7b7d, '', 7, 3, 0, '', 'admin/structure/types', 'Content types', 't', '', '', 'a:0:{}', 6, 'Manage content types, including default status, front page promotion, comment settings, etc.', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/add', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31343a226e6f64655f747970655f666f726d223b7d, '', 15, 4, 1, 'admin/structure/types', 'admin/structure/types', 'Add content type', 't', '', '', 'a:0:{}', 388, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/list', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'node_overview_types', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/types', 'admin/structure/types', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226e6f64655f747970655f666f726d223b693a313b693a343b7d, '', 30, 5, 0, '', 'admin/structure/types/manage/%', 'Edit content type', 'node_type_page_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/comment/display', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment display', 't', '', '', 'a:0:{}', 132, '', '', 4, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/default', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 247, 8, 1, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/display/full', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b693a333b733a343a2266756c6c223b7d, '', 247, 8, 1, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%', 'Full comment', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields', 0x613a313a7b693a343b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a373a22636f6d6d656e74223b693a323b693a343b7d, '', 123, 7, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Comment fields', 't', '', '', 'a:0:{}', 132, '', '', 3, 'modules/field_ui/field_ui.admin.inc');
INSERT INTO `jbqo_menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('admin/structure/types/manage/%/comment/fields/%', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 246, 8, 0, '', 'admin/structure/types/manage/%/comment/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:7;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/delete', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/edit', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/field-settings', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/comment/fields/%/widget-type', 0x613a323a7b693a343b613a313a7b733a32323a22636f6d6d656e745f6e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a373b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a373a22636f6d6d656e74223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a373b7d, '', 493, 9, 1, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/delete', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226e6f64655f747970655f64656c6574655f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/types/manage/%/delete', 'Delete', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/display', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage display', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/default', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a373a2264656661756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a373a2264656661756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Default', 't', '', '', 'a:0:{}', 140, '', '', -10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/full', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a343a2266756c6c223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a343a2266756c6c223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Full content', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/rss', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a333a22727373223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a333a22727373223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'RSS', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_index', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a31323a227365617263685f696e646578223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a31323a227365617263685f696e646578223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search index', 't', '', '', 'a:0:{}', 132, '', '', 3, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/search_result', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a31333a227365617263685f726573756c74223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a31333a227365617263685f726573756c74223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Search result highlighting input', 't', '', '', 'a:0:{}', 132, '', '', 4, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/display/teaser', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', '_field_ui_view_mode_menu_access', 0x613a363a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a363a22746561736572223b693a333b733a32313a226669656c645f75695f61646d696e5f616363657373223b693a343b733a31313a22757365725f616363657373223b693a353b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a343a7b693a303b733a33303a226669656c645f75695f646973706c61795f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b693a333b733a363a22746561736572223b7d, '', 123, 7, 1, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%', 'Teaser', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/edit', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31343a226e6f64655f747970655f666f726d223b693a313b693a343b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/node/content_types.inc'),
('admin/structure/types/manage/%/fields', 0x613a313a7b693a343b733a31343a226e6f64655f747970655f6c6f6164223b7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a333a7b693a303b733a32383a226669656c645f75695f6669656c645f6f766572766965775f666f726d223b693a313b733a343a226e6f6465223b693a323b693a343b7d, '', 61, 6, 1, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Manage fields', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a363b7d, '', 122, 7, 0, '', 'admin/structure/types/manage/%/fields/%', '', 'field_ui_menu_title', 'a:1:{i:0;i:6;}', '', 'a:0:{}', 6, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/delete', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32363a226669656c645f75695f6669656c645f64656c6574655f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/edit', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a226669656c645f75695f6669656c645f656469745f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Edit', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/field-settings', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226669656c645f75695f6669656c645f73657474696e67735f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Field settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/types/manage/%/fields/%/widget-type', 0x613a323a7b693a343b613a313a7b733a31343a226e6f64655f747970655f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d693a363b613a313a7b733a31383a226669656c645f75695f6d656e755f6c6f6164223b613a343a7b693a303b733a343a226e6f6465223b693a313b693a343b693a323b733a313a2234223b693a333b733a343a22256d6170223b7d7d7d, '', 'field_ui_admin_access', 0x613a323a7b693a303b733a31313a22757365725f616363657373223b693a313b613a313a7b693a303b733a32343a2261646d696e697374657220636f6e74656e74207479706573223b7d7d, 'drupal_get_form', 0x613a323a7b693a303b733a32353a226669656c645f75695f7769646765745f747970655f666f726d223b693a313b693a363b7d, '', 245, 8, 1, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', 'Widget type', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/field_ui/field_ui.admin.inc'),
('admin/structure/views', '', '', 'ctools_export_ui_task_access', 0x613a323a7b693a303b733a383a2276696577735f7569223b693a313b733a343a226c697374223b7d, 'ctools_export_ui_switcher_page', 0x613a323a7b693a303b733a383a2276696577735f7569223b693a313b733a343a226c697374223b7d, '', 7, 3, 0, '', 'admin/structure/views', 'Views', 't', '', '', 'a:0:{}', 6, 'Manage customized lists of content.', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/add', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_add_page', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/views', 'admin/structure/views', 'Add new view', 't', '', '', 'a:0:{}', 388, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/add-template', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_add_template_page', 0x613a303a7b7d, '', 15, 4, 1, 'admin/structure/views', 'admin/structure/views', 'Add view from template', 't', '', '', 'a:0:{}', 388, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/ajax/%/%', 0x613a323a7b693a343b4e3b693a353b733a31393a2276696577735f75695f63616368655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_ajax_form', 0x613a333a7b693a303b623a313b693a313b693a343b693a323b693a353b7d, 'ajax_deliver', 60, 6, 0, '', 'admin/structure/views/ajax/%/%', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/ajax/preview/%/%', 0x613a323a7b693a353b733a31393a2276696577735f75695f63616368655f6c6f6164223b693a363b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_preview', 0x613a323a7b693a303b693a353b693a313b693a363b7d, 'ajax_deliver', 124, 7, 0, '', 'admin/structure/views/ajax/preview/%/%', '', 't', '', '', 'a:0:{}', 6, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/import', '', '', 'views_import_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a2276696577735f75695f696d706f72745f70616765223b7d, '', 15, 4, 1, 'admin/structure/views', 'admin/structure/views', 'Import', 't', '', '', 'a:0:{}', 388, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/list', '', '', 'ctools_export_ui_task_access', 0x613a323a7b693a303b733a383a2276696577735f7569223b693a313b733a343a226c697374223b7d, 'ctools_export_ui_switcher_page', 0x613a323a7b693a303b733a383a2276696577735f7569223b693a313b733a343a226c697374223b7d, '', 15, 4, 1, 'admin/structure/views', 'admin/structure/views', 'List', 't', '', '', 'a:0:{}', 140, '', '', -10, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/nojs/%/%', 0x613a323a7b693a343b4e3b693a353b733a31393a2276696577735f75695f63616368655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_ajax_form', 0x613a333a7b693a303b623a303b693a313b693a343b693a323b693a353b7d, '', 60, 6, 0, '', 'admin/structure/views/nojs/%/%', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/nojs/preview/%/%', 0x613a323a7b693a353b733a31393a2276696577735f75695f63616368655f6c6f6164223b693a363b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_preview', 0x613a323a7b693a303b693a353b693a313b693a363b7d, '', 124, 7, 0, '', 'admin/structure/views/nojs/preview/%/%', '', 't', '', '', 'a:0:{}', 6, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/settings', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32393a2276696577735f75695f61646d696e5f73657474696e67735f6261736963223b7d, '', 15, 4, 1, 'admin/structure/views', 'admin/structure/views', 'Settings', 't', '', '', 'a:0:{}', 132, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/settings/advanced', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a2276696577735f75695f61646d696e5f73657474696e67735f616476616e636564223b7d, '', 31, 5, 1, 'admin/structure/views/settings', 'admin/structure/views', 'Advanced', 't', '', '', 'a:0:{}', 132, '', '', 1, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/settings/basic', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32393a2276696577735f75695f61646d696e5f73657474696e67735f6261736963223b7d, '', 31, 5, 1, 'admin/structure/views/settings', 'admin/structure/views', 'Basic', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/template/%/add', 0x613a313a7b693a343b4e3b7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a31323a226164645f74656d706c617465223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a31323a226164645f74656d706c617465223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/template/%/add', 'Add from template', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/view/%', 0x613a313a7b693a343b733a31393a2276696577735f75695f63616368655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_edit_page', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'admin/structure/views/view/%', '', 'views_ui_edit_page_title', 'a:1:{i:0;i:4;}', '', 'a:0:{}', 6, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/view/%/break-lock', 0x613a313a7b693a343b733a31393a2276696577735f75695f63616368655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32373a2276696577735f75695f627265616b5f6c6f636b5f636f6e6669726d223b693a313b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/break-lock', 'Break lock', 't', '', '', 'a:0:{}', 4, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/view/%/clone', 0x613a313a7b693a343b613a313a7b733a32313a2263746f6f6c735f6578706f72745f75695f6c6f6164223b613a313a7b693a303b733a383a2276696577735f7569223b7d7d7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a353a22636c6f6e65223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a353a22636c6f6e65223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/clone', 'Clone', 't', '', '', 'a:0:{}', 4, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/view/%/delete', 0x613a313a7b693a343b613a313a7b733a32313a2263746f6f6c735f6578706f72745f75695f6c6f6164223b613a313a7b693a303b733a383a2276696577735f7569223b7d7d7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a2264656c657465223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a2264656c657465223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/delete', 'Delete', 't', '', '', 'a:0:{}', 4, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/view/%/disable', 0x613a313a7b693a343b613a313a7b733a32313a2263746f6f6c735f6578706f72745f75695f6c6f6164223b613a313a7b693a303b733a383a2276696577735f7569223b7d7d7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a373a2264697361626c65223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a373a2264697361626c65223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/disable', 'Disable', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/view/%/edit', 0x613a313a7b693a343b733a31393a2276696577735f75695f63616368655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_edit_page', 0x613a313a7b693a303b693a343b7d, '', 61, 6, 3, 'admin/structure/views/view/%', 'admin/structure/views/view/%', 'Edit view', 't', '', 'ajax_base_page_theme', 'a:0:{}', 140, '', '', -10, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/view/%/edit/%/ajax', 0x613a323a7b693a343b733a31393a2276696577735f75695f63616368655f6c6f6164223b693a363b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_ajax_get_form', 0x613a333a7b693a303b733a31383a2276696577735f75695f656469745f666f726d223b693a313b693a343b693a323b693a363b7d, 'ajax_deliver', 245, 8, 0, '', 'admin/structure/views/view/%/edit/%/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/view/%/enable', 0x613a313a7b693a343b613a313a7b733a32313a2263746f6f6c735f6578706f72745f75695f6c6f6164223b613a313a7b693a303b733a383a2276696577735f7569223b7d7d7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a22656e61626c65223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a22656e61626c65223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/enable', 'Enable', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/view/%/export', 0x613a313a7b693a343b613a313a7b733a32313a2263746f6f6c735f6578706f72745f75695f6c6f6164223b613a313a7b693a303b733a383a2276696577735f7569223b7d7d7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a226578706f7274223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a226578706f7274223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/export', 'Export', 't', '', '', 'a:0:{}', 4, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/structure/views/view/%/preview/%', 0x613a323a7b693a343b733a31393a2276696577735f75695f63616368655f6c6f6164223b693a363b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_build_preview', 0x613a323a7b693a303b693a343b693a313b693a363b7d, '', 122, 7, 3, '', 'admin/structure/views/view/%/preview/%', '', 't', '', '', 'a:0:{}', 4, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/view/%/preview/%/ajax', 0x613a323a7b693a343b733a31393a2276696577735f75695f63616368655f6c6f6164223b693a363b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_build_preview', 0x613a323a7b693a303b693a343b693a313b693a363b7d, 'ajax_deliver', 245, 8, 0, '', 'admin/structure/views/view/%/preview/%/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/structure/views/view/%/revert', 0x613a313a7b693a343b613a313a7b733a32313a2263746f6f6c735f6578706f72745f75695f6c6f6164223b613a313a7b693a303b733a383a2276696577735f7569223b7d7d7d, '', 'ctools_export_ui_task_access', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a22726576657274223b693a323b693a343b7d, 'ctools_export_ui_switcher_page', 0x613a333a7b693a303b733a383a2276696577735f7569223b693a313b733a363a2264656c657465223b693a323b693a343b7d, '', 61, 6, 0, '', 'admin/structure/views/view/%/revert', 'Revert', 't', '', '', 'a:0:{}', 4, '', '', 0, 'sites/all/modules/contrib/ctools/includes/export-ui.inc'),
('admin/tasks', '', '', 'user_access', 0x613a313a7b693a303b733a32373a226163636573732061646d696e697374726174696f6e207061676573223b7d, 'system_admin_menu_block_page', 0x613a303a7b7d, '', 3, 2, 1, 'admin', 'admin', 'Tasks', 't', '', '', 'a:0:{}', 140, '', '', -20, 'modules/system/system.admin.inc'),
('admin/update/ready', '', '', 'update_manager_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a33323a227570646174655f6d616e616765725f7570646174655f72656164795f666f726d223b7d, '', 7, 3, 0, '', 'admin/update/ready', 'Ready to update', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/update/update.manager.inc'),
('admin/views/ajax/autocomplete/tag', '', '', 'user_access', 0x613a313a7b693a303b733a31363a2261646d696e6973746572207669657773223b7d, 'views_ui_autocomplete_tag', 0x613a303a7b7d, '', 31, 5, 0, '', 'admin/views/ajax/autocomplete/tag', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/admin.inc'),
('admin/views/ajax/autocomplete/taxonomy', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'views_ajax_autocomplete_taxonomy', 0x613a303a7b7d, '', 31, 5, 0, '', 'admin/views/ajax/autocomplete/taxonomy', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/ajax.inc'),
('admin/views/ajax/autocomplete/user', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261636365737320757365722070726f66696c6573223b7d, 'views_ajax_autocomplete_user', 0x613a303a7b7d, '', 31, 5, 0, '', 'admin/views/ajax/autocomplete/user', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/views/includes/ajax.inc'),
('batch', '', '', '1', 0x613a303a7b7d, 'system_batch_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'batch', '', 't', '', '_system_batch_theme', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('comment/%', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261636365737320636f6d6d656e7473223b7d, 'comment_permalink', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'comment/%', 'Comment permalink', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('comment/%/approve', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_approve', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 0, '', 'comment/%/approve', 'Approve', 't', '', '', 'a:0:{}', 6, '', '', 1, 'modules/comment/comment.pages.inc'),
('comment/%/delete', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e697374657220636f6d6d656e7473223b7d, 'comment_confirm_delete_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/comment/comment.admin.inc'),
('comment/%/devel', 0x613a313a7b693a313b733a31323a22636f6d6d656e745f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a323a7b693a303b733a373a22636f6d6d656e74223b693a313b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Devel', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('comment/%/devel/load', 0x613a313a7b693a313b733a31323a22636f6d6d656e745f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a323a7b693a303b733a373a22636f6d6d656e74223b693a313b693a313b7d, '', 11, 4, 1, 'comment/%/devel', 'comment/%', 'Load', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('comment/%/devel/render', 0x613a313a7b693a313b733a31323a22636f6d6d656e745f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_render_object', 0x613a323a7b693a303b733a373a22636f6d6d656e74223b693a313b693a313b7d, '', 11, 4, 1, 'comment/%/devel', 'comment/%', 'Render', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('comment/%/edit', 0x613a313a7b693a313b733a31323a22636f6d6d656e745f6c6f6164223b7d, '', 'comment_access', 0x613a323a7b693a303b733a343a2265646974223b693a313b693a313b7d, 'comment_edit_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, ''),
('comment/%/view', 0x613a313a7b693a313b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31353a2261636365737320636f6d6d656e7473223b7d, 'comment_permalink', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'comment/%', 'comment/%', 'View comment', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('comment/reply/%', 0x613a313a7b693a323b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a323b7d, 'comment_reply', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'comment/reply/%', 'Add new comment', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/comment/comment.pages.inc'),
('ctools/autocomplete/%', 0x613a313a7b693a323b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_content_autocomplete_entity', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'ctools/autocomplete/%', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/content.menu.inc'),
('ctools/context/ajax/access/add', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_access_ajax_add', 0x613a303a7b7d, '', 31, 5, 0, '', 'ctools/context/ajax/access/add', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/context-access-admin.inc'),
('ctools/context/ajax/access/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_access_ajax_edit', 0x613a303a7b7d, '', 31, 5, 0, '', 'ctools/context/ajax/access/configure', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/context-access-admin.inc'),
('ctools/context/ajax/access/delete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_access_ajax_delete', 0x613a303a7b7d, '', 31, 5, 0, '', 'ctools/context/ajax/access/delete', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/context-access-admin.inc'),
('ctools/context/ajax/add', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_context_ajax_item_add', 0x613a303a7b7d, '', 15, 4, 0, '', 'ctools/context/ajax/add', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/context-admin.inc'),
('ctools/context/ajax/configure', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_context_ajax_item_edit', 0x613a303a7b7d, '', 15, 4, 0, '', 'ctools/context/ajax/configure', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/context-admin.inc'),
('ctools/context/ajax/delete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'ctools_context_ajax_item_delete', 0x613a303a7b7d, '', 15, 4, 0, '', 'ctools/context/ajax/delete', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/ctools/includes/context-admin.inc'),
('devel/arguments', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_querylog_arguments', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/arguments', 'Arguments query', 't', '', '', 'a:0:{}', 0, 'Return a given query, with arguments instead of placeholders. Used by query log', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/cache/clear', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_cache_clear', 0x613a303a7b7d, '', 7, 3, 0, '', 'devel/cache/clear', 'Clear cache', 't', '', '', 'a:0:{}', 6, 'Clear the CSS cache and all database cache tables which store page, node, theme and variable caches.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/elements', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_elements_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/elements', 'Hook_elements()', 't', '', '', 'a:0:{}', 6, 'View the active form/render elements for this site.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/entity/info', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_entity_info_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'devel/entity/info', 'Entity info', 't', '', '', 'a:0:{}', 6, 'View entity information across the whole site.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/explain', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_querylog_explain', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/explain', 'Explain query', 't', '', '', 'a:0:{}', 0, 'Run an EXPLAIN on a given query. Used by query log', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/field/info', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_field_info_page', 0x613a303a7b7d, '', 7, 3, 0, '', 'devel/field/info', 'Field info', 't', '', '', 'a:0:{}', 6, 'View fields information across the whole site.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/menu/item', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_menu_item', 0x613a303a7b7d, '', 7, 3, 0, '', 'devel/menu/item', 'Menu item', 't', '', '', 'a:0:{}', 6, 'Details about a given menu item.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/menu/reset', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a22646576656c5f6d656e755f72656275696c64223b7d, '', 7, 3, 0, '', 'devel/menu/reset', 'Rebuild menus', 't', '', '', 'a:0:{}', 6, 'Rebuild menu based on hook_menu() and revert any custom changes. All menu items return to their default settings.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/php', '', '', 'user_access', 0x613a313a7b693a303b733a31363a22657865637574652070687020636f6465223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a22646576656c5f657865637574655f666f726d223b7d, '', 3, 2, 0, '', 'devel/php', 'Execute PHP Code', 't', '', '', 'a:0:{}', 6, 'Execute some PHP code', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/phpinfo', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_phpinfo', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/phpinfo', 'PHPinfo()', 't', '', '', 'a:0:{}', 6, 'View your server\'s PHP configuration', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/reference', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_function_reference', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/reference', 'Function reference', 't', '', '', 'a:0:{}', 6, 'View a list of currently defined user functions with documentation links.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/reinstall', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31353a22646576656c5f7265696e7374616c6c223b7d, '', 3, 2, 0, '', 'devel/reinstall', 'Reinstall modules', 't', '', '', 'a:0:{}', 6, 'Run hook_uninstall() and then hook_install() for a given module.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/run-cron', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'system_run_cron', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/run-cron', 'Run cron', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/system/system.admin.inc'),
('devel/session', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_session', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/session', 'Session viewer', 't', '', '', 'a:0:{}', 6, 'List the contents of $_SESSION.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/settings', '', '', 'user_access', 0x613a313a7b693a303b733a32393a2261646d696e6973746572207369746520636f6e66696775726174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a32303a22646576656c5f61646d696e5f73657474696e6773223b7d, '', 3, 2, 0, '', 'devel/settings', 'Devel settings', 't', '', '', 'a:0:{}', 6, 'Helper functions, pages, and blocks to assist Drupal developers. The devel blocks can be managed via the <a href=\"/admin/structure/block\">block administration</a> page.', '', 0, 'sites/all/modules/contrib/devel/devel.admin.inc'),
('devel/switch', '', '', '_devel_switch_user_access', 0x613a313a7b693a303b693a323b7d, 'devel_switch_user', 0x613a303a7b7d, '', 3, 2, 0, '', 'devel/switch', 'Switch user', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/theme/registry', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_theme_registry', 0x613a303a7b7d, '', 7, 3, 0, '', 'devel/theme/registry', 'Theme registry', 't', '', '', 'a:0:{}', 6, 'View a list of available theme functions across the whole site.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/variable', '', '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31393a22646576656c5f7661726961626c655f666f726d223b7d, '', 3, 2, 0, '', 'devel/variable', 'Variable editor', 't', '', '', 'a:0:{}', 6, 'Edit and delete site variables.', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('devel/variable/edit/%', 0x613a313a7b693a333b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a22646576656c5f7661726961626c655f65646974223b693a313b693a333b7d, '', 14, 4, 0, '', 'devel/variable/edit/%', 'Variable editor', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('features/ajaxcallback/%', 0x613a313a7b693a323b4e3b7d, '', 'user_access', 0x613a313a7b693a303b733a31393a2261646d696e6973746572206665617475726573223b7d, 'features_export_components_json', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'features/ajaxcallback/%', 'AJAX callback', 't', '', '', 'a:0:{}', 0, 'Return components of a feature.', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('features/autocomplete/packages', '', '', 'user_access', 0x613a313a7b693a303b733a31353a226d616e616765206665617475726573223b7d, 'features_autocomplete_packages', 0x613a303a7b7d, '', 7, 3, 0, '', 'features/autocomplete/packages', '', 't', '', '', 'a:0:{}', 0, '', '', 0, 'sites/all/modules/contrib/features/features.admin.inc'),
('file/ajax', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'file_ajax_upload', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'file/ajax', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, ''),
('file/progress', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'file_ajax_progress', 0x613a303a7b7d, '', 3, 2, 0, '', 'file/progress', '', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, ''),
('filter/tips', '', '', '1', 0x613a303a7b7d, 'filter_tips_long', 0x613a303a7b7d, '', 3, 2, 0, '', 'filter/tips', 'Compose tips', 't', '', '', 'a:0:{}', 20, '', '', 0, 'modules/filter/filter.pages.inc'),
('filter/tips/%', 0x613a313a7b693a323b733a31383a2266696c7465725f666f726d61745f6c6f6164223b7d, '', 'filter_access', 0x613a313a7b693a303b693a323b7d, 'filter_tips_long', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'filter/tips/%', 'Compose tips', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/filter/filter.pages.inc'),
('jobs', '', '', 'views_access', 0x613a313a7b693a303b613a323a7b693a303b733a31363a2276696577735f636865636b5f7065726d223b693a313b613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d7d7d, 'views_page', 0x613a323a7b693a303b733a343a226a6f6273223b693a313b733a343a2270616765223b7d, '', 1, 1, 0, '', 'jobs', 'Jobs', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('node', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'node_page_default', 0x613a303a7b7d, '', 1, 1, 0, '', 'node', '', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('node/%', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a313b7d, 'node_page_view', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'node/%', '', 'node_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', 6, '', '', 0, ''),
('node/%/delete', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a363a2264656c657465223b693a313b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a226e6f64655f64656c6574655f636f6e6669726d223b693a313b693a313b7d, '', 5, 3, 2, 'node/%', 'node/%', 'Delete', 't', '', '', 'a:0:{}', 132, '', '', 1, 'modules/node/node.pages.inc'),
('node/%/devel', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'Devel', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('node/%/devel/load', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b693a313b7d, '', 11, 4, 1, 'node/%/devel', 'node/%', 'Load', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('node/%/devel/render', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_render_object', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b693a313b7d, '', 11, 4, 1, 'node/%/devel', 'node/%', 'Render', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('node/%/edit', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a363a22757064617465223b693a313b693a313b7d, 'node_page_edit', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 3, 'node/%', 'node/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', '_node_revision_access', 0x613a313a7b693a303b693a313b7d, 'node_revision_overview', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'Revisions', 't', '', '', 'a:0:{}', 132, '', '', 2, 'modules/node/node.pages.inc'),
('node/%/revisions/%/delete', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a323a7b693a303b693a313b693a313b733a363a2264656c657465223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226e6f64655f7265766973696f6e5f64656c6574655f636f6e6669726d223b693a313b693a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/delete', 'Delete earlier revision', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc');
INSERT INTO `jbqo_menu_router` (`path`, `load_functions`, `to_arg_functions`, `access_callback`, `access_arguments`, `page_callback`, `page_arguments`, `delivery_callback`, `fit`, `number_parts`, `context`, `tab_parent`, `tab_root`, `title`, `title_callback`, `title_arguments`, `theme_callback`, `theme_arguments`, `type`, `description`, `position`, `weight`, `include_file`) VALUES
('node/%/revisions/%/revert', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a323a7b693a303b693a313b693a313b733a363a22757064617465223b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32383a226e6f64655f7265766973696f6e5f7265766572745f636f6e6669726d223b693a313b693a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/revert', 'Revert to earlier revision', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/%/revisions/%/view', 0x613a323a7b693a313b613a313a7b733a393a226e6f64655f6c6f6164223b613a313a7b693a303b693a333b7d7d693a333b4e3b7d, '', '_node_revision_access', 0x613a313a7b693a303b693a313b7d, 'node_show', 0x613a323a7b693a303b693a313b693a313b623a313b7d, '', 21, 5, 0, '', 'node/%/revisions/%/view', 'Revisions', 't', '', '', 'a:0:{}', 6, '', '', 0, ''),
('node/%/view', 0x613a313a7b693a313b733a393a226e6f64655f6c6f6164223b7d, '', 'node_access', 0x613a323a7b693a303b733a343a2276696577223b693a313b693a313b7d, 'node_page_view', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'node/%', 'node/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('node/add', '', '', '_node_add_access', 0x613a303a7b7d, 'node_add_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'node/add', 'Add content', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/node/node.pages.inc'),
('node/add/article', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a373a2261727469636c65223b7d, 'node_add', 0x613a313a7b693a303b733a373a2261727469636c65223b7d, '', 7, 3, 0, '', 'node/add/article', 'Article', 'check_plain', '', '', 'a:0:{}', 6, 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 0, 'modules/node/node.pages.inc'),
('node/add/job', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a333a226a6f62223b7d, 'node_add', 0x613a313a7b693a303b733a333a226a6f62223b7d, '', 7, 3, 0, '', 'node/add/job', 'Job', 'check_plain', '', '', 'a:0:{}', 6, 'Create job entity', '', 0, 'modules/node/node.pages.inc'),
('node/add/page', '', '', 'node_access', 0x613a323a7b693a303b733a363a22637265617465223b693a313b733a343a2270616765223b7d, 'node_add', 0x613a313a7b693a303b733a343a2270616765223b7d, '', 7, 3, 0, '', 'node/add/page', 'Basic page', 'check_plain', '', '', 'a:0:{}', 6, 'Use <em>basic pages</em> for your static content, such as an \'About us\' page.', '', 0, 'modules/node/node.pages.inc'),
('rss.xml', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'node_feed', 0x613a323a7b693a303b623a303b693a313b613a303a7b7d7d, '', 1, 1, 0, '', 'rss.xml', 'RSS feed', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('search', '', '', 'search_is_active', 0x613a303a7b7d, 'search_view', 0x613a303a7b7d, '', 1, 1, 0, '', 'search', 'Search', 't', '', '', 'a:0:{}', 20, '', '', 0, 'modules/search/search.pages.inc'),
('search/node', '', '', '_search_menu_access', 0x613a313a7b693a303b733a343a226e6f6465223b7d, 'search_view', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b733a303a22223b7d, '', 3, 2, 1, 'search', 'search', 'Content', 't', '', '', 'a:0:{}', 132, '', '', -10, 'modules/search/search.pages.inc'),
('search/node/%', 0x613a313a7b693a323b613a313a7b733a31343a226d656e755f7461696c5f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, 0x613a313a7b693a323b733a31363a226d656e755f7461696c5f746f5f617267223b7d, '_search_menu_access', 0x613a313a7b693a303b733a343a226e6f6465223b7d, 'search_view', 0x613a323a7b693a303b733a343a226e6f6465223b693a313b693a323b7d, '', 6, 3, 1, 'search/node', 'search/node/%', 'Content', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('search/user', '', '', '_search_menu_access', 0x613a313a7b693a303b733a343a2275736572223b7d, 'search_view', 0x613a323a7b693a303b733a343a2275736572223b693a313b733a303a22223b7d, '', 3, 2, 1, 'search', 'search', 'Users', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('search/user/%', 0x613a313a7b693a323b613a313a7b733a31343a226d656e755f7461696c5f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, 0x613a313a7b693a323b733a31363a226d656e755f7461696c5f746f5f617267223b7d, '_search_menu_access', 0x613a313a7b693a303b733a343a2275736572223b7d, 'search_view', 0x613a323a7b693a303b733a343a2275736572223b693a313b693a323b7d, '', 6, 3, 1, 'search/node', 'search/node/%', 'Users', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/search/search.pages.inc'),
('sites/default/files/styles/%', 0x613a313a7b693a343b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', '1', 0x613a303a7b7d, 'image_style_deliver', 0x613a313a7b693a303b693a343b7d, '', 30, 5, 0, '', 'sites/default/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/ajax', '', '', '1', 0x613a303a7b7d, 'ajax_form_callback', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'system/ajax', 'AHAH callback', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, '', '', 0, 'includes/form.inc'),
('system/files', '', '', '1', 0x613a303a7b7d, 'file_download', 0x613a313a7b693a303b733a373a2270726976617465223b7d, '', 3, 2, 0, '', 'system/files', 'File download', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/files/styles/%', 0x613a313a7b693a333b733a31363a22696d6167655f7374796c655f6c6f6164223b7d, '', '1', 0x613a303a7b7d, 'image_style_deliver', 0x613a313a7b693a303b693a333b7d, '', 14, 4, 0, '', 'system/files/styles/%', 'Generate image style', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/temporary', '', '', '1', 0x613a303a7b7d, 'file_download', 0x613a313a7b693a303b733a393a2274656d706f72617279223b7d, '', 3, 2, 0, '', 'system/temporary', 'Temporary files', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('system/timezone', '', '', '1', 0x613a303a7b7d, 'system_timezone', 0x613a303a7b7d, '', 3, 2, 0, '', 'system/timezone', 'Time zone', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/system/system.admin.inc'),
('taxonomy/autocomplete', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_autocomplete', 0x613a303a7b7d, '', 3, 2, 0, '', 'taxonomy/autocomplete', 'Autocomplete taxonomy', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_page', 0x613a313a7b693a303b693a323b7d, '', 6, 3, 0, '', 'taxonomy/term/%', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', 6, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/devel', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a333a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a323b693a323b733a343a227465726d223b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'Devel', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('taxonomy/term/%/devel/load', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a333a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a323b693a323b733a343a227465726d223b7d, '', 27, 5, 1, 'taxonomy/term/%/devel', 'taxonomy/term/%', 'Load', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('taxonomy/term/%/devel/render', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_render_object', 0x613a333a7b693a303b733a31333a227461786f6e6f6d795f7465726d223b693a313b693a323b693a323b733a343a227465726d223b7d, '', 27, 5, 1, 'taxonomy/term/%/devel', 'taxonomy/term/%', 'Render', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('taxonomy/term/%/edit', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'taxonomy_term_edit_access', 0x613a313a7b693a303b693a323b7d, 'drupal_get_form', 0x613a333a7b693a303b733a31383a227461786f6e6f6d795f666f726d5f7465726d223b693a313b693a323b693a323b4e3b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 10, 'modules/taxonomy/taxonomy.admin.inc'),
('taxonomy/term/%/feed', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_feed', 0x613a313a7b693a303b693a323b7d, '', 13, 4, 0, '', 'taxonomy/term/%/feed', 'Taxonomy term', 'taxonomy_term_title', 'a:1:{i:0;i:2;}', '', 'a:0:{}', 0, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('taxonomy/term/%/view', 0x613a313a7b693a323b733a31383a227461786f6e6f6d795f7465726d5f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320636f6e74656e74223b7d, 'taxonomy_term_page', 0x613a313a7b693a303b693a323b7d, '', 13, 4, 1, 'taxonomy/term/%', 'taxonomy/term/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/taxonomy/taxonomy.pages.inc'),
('toolbar/toggle', '', '', 'user_access', 0x613a313a7b693a303b733a31343a2261636365737320746f6f6c626172223b7d, 'toolbar_toggle_page', 0x613a303a7b7d, '', 3, 2, 0, '', 'toolbar/toggle', 'Toggle drawer visibility', 't', '', '', 'a:0:{}', 0, '', '', 0, ''),
('user', '', '', '1', 0x613a303a7b7d, 'user_page', 0x613a303a7b7d, '', 1, 1, 0, '', 'user', 'User account', 'user_menu_title', '', '', 'a:0:{}', 6, '', '', -10, 'modules/user/user.pages.inc'),
('user/%', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_view_access', 0x613a313a7b693a303b693a313b7d, 'user_view_page', 0x613a313a7b693a303b693a313b7d, '', 2, 2, 0, '', 'user/%', 'My account', 'user_page_title', 'a:1:{i:0;i:1;}', '', 'a:0:{}', 6, '', '', 0, ''),
('user/%/cancel', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_cancel_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a32343a22757365725f63616e63656c5f636f6e6669726d5f666f726d223b693a313b693a313b7d, '', 5, 3, 0, '', 'user/%/cancel', 'Cancel account', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/cancel/confirm/%/%', 0x613a333a7b693a313b733a393a22757365725f6c6f6164223b693a343b4e3b693a353b4e3b7d, '', 'user_cancel_access', 0x613a313a7b693a303b693a313b7d, 'user_cancel_confirm', 0x613a333a7b693a303b693a313b693a313b693a343b693a323b693a353b7d, '', 44, 6, 0, '', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 't', '', '', 'a:0:{}', 6, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/devel', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a323a7b693a303b733a343a2275736572223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Devel', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('user/%/devel/load', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_load_object', 0x613a323a7b693a303b733a343a2275736572223b693a313b693a313b7d, '', 11, 4, 1, 'user/%/devel', 'user/%', 'Load', 't', '', '', 'a:0:{}', 140, '', '', 0, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('user/%/devel/render', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_access', 0x613a313a7b693a303b733a32343a2261636365737320646576656c20696e666f726d6174696f6e223b7d, 'devel_render_object', 0x613a323a7b693a303b733a343a2275736572223b693a313b693a313b7d, '', 11, 4, 1, 'user/%/devel', 'user/%', 'Render', 't', '', '', 'a:0:{}', 132, '', '', 100, 'sites/all/modules/contrib/devel/devel.pages.inc'),
('user/%/edit', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_edit_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Edit', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/edit/account', 0x613a313a7b693a313b613a313a7b733a31383a22757365725f63617465676f72795f6c6f6164223b613a323a7b693a303b733a343a22256d6170223b693a313b733a363a2225696e646578223b7d7d7d, '', 'user_edit_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31373a22757365725f70726f66696c655f666f726d223b693a313b693a313b7d, '', 11, 4, 1, 'user/%/edit', 'user/%', 'Account', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/user/user.pages.inc'),
('user/%/shortcuts', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'shortcut_set_switch_access', 0x613a313a7b693a303b693a313b7d, 'drupal_get_form', 0x613a323a7b693a303b733a31393a2273686f72746375745f7365745f737769746368223b693a313b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'Shortcuts', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/shortcut/shortcut.admin.inc'),
('user/%/view', 0x613a313a7b693a313b733a393a22757365725f6c6f6164223b7d, '', 'user_view_access', 0x613a313a7b693a303b693a313b7d, 'user_view_page', 0x613a313a7b693a303b693a313b7d, '', 5, 3, 1, 'user/%', 'user/%', 'View', 't', '', '', 'a:0:{}', 140, '', '', -10, ''),
('user/autocomplete', '', '', 'user_access', 0x613a313a7b693a303b733a32303a2261636365737320757365722070726f66696c6573223b7d, 'user_autocomplete', 0x613a303a7b7d, '', 3, 2, 0, '', 'user/autocomplete', 'User autocomplete', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/user/user.pages.inc'),
('user/login', '', '', 'user_is_anonymous', 0x613a303a7b7d, 'user_page', 0x613a303a7b7d, '', 3, 2, 1, 'user', 'user', 'Log in', 't', '', '', 'a:0:{}', 140, '', '', 0, 'modules/user/user.pages.inc'),
('user/logout', '', '', 'user_is_logged_in', 0x613a303a7b7d, 'user_logout', 0x613a303a7b7d, '', 3, 2, 0, '', 'user/logout', 'Log out', 't', '', '', 'a:0:{}', 6, '', '', 10, 'modules/user/user.pages.inc'),
('user/password', '', '', '1', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a393a22757365725f70617373223b7d, '', 3, 2, 1, 'user', 'user', 'Request new password', 't', '', '', 'a:0:{}', 132, '', '', 0, 'modules/user/user.pages.inc'),
('user/register', '', '', 'user_register_access', 0x613a303a7b7d, 'drupal_get_form', 0x613a313a7b693a303b733a31383a22757365725f72656769737465725f666f726d223b7d, '', 3, 2, 1, 'user', 'user', 'Create new account', 't', '', '', 'a:0:{}', 132, '', '', 0, ''),
('user/reset/%/%/%', 0x613a333a7b693a323b4e3b693a333b4e3b693a343b4e3b7d, '', '1', 0x613a303a7b7d, 'drupal_get_form', 0x613a343a7b693a303b733a31353a22757365725f706173735f7265736574223b693a313b693a323b693a323b693a333b693a333b693a343b7d, '', 24, 5, 0, '', 'user/reset/%/%/%', 'Reset password', 't', '', '', 'a:0:{}', 0, '', '', 0, 'modules/user/user.pages.inc'),
('views/ajax', '', '', '1', 0x613a303a7b7d, 'views_ajax', 0x613a303a7b7d, 'ajax_deliver', 3, 2, 0, '', 'views/ajax', 'Views', 't', '', 'ajax_base_page_theme', 'a:0:{}', 0, 'Ajax callback for view loading.', '', 0, 'sites/all/modules/contrib/views/includes/ajax.inc');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_node`
--

CREATE TABLE `jbqo_node` (
  `nid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for a node.',
  `vid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The current `jbqo_node_revision`.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The `jbqo_node_type`.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The `jbqo_languages`.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT 0 COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this translation page needs to be updated.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';

--
-- Dumping data for table `jbqo_node`
--

INSERT INTO `jbqo_node` (`nid`, `vid`, `type`, `language`, `title`, `uid`, `status`, `created`, `changed`, `comment`, `promote`, `sticky`, `tnid`, `translate`) VALUES
(1, 1, 'article', 'und', 'Drupal test', 1, 1, 1608028764, 1608028764, 2, 1, 0, 0, 0),
(2, 2, 'job', 'und', 'Testing job 1', 1, 1, 1608029823, 1608029823, 1, 0, 0, 0, 0),
(3, 3, 'job', 'und', 'Testing job 2', 1, 1, 1608029911, 1608041774, 1, 0, 0, 0, 0),
(4, 4, 'job', 'und', 'Testing job 3', 1, 1, 1608029929, 1608037246, 1, 0, 0, 0, 0),
(5, 5, 'job', 'und', 'Testing job 4', 1, 1, 1608029945, 1608040768, 1, 0, 0, 0, 0),
(6, 6, 'job', 'und', 'Testing job 5', 1, 1, 1608029958, 1608029958, 1, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_node_access`
--

CREATE TABLE `jbqo_node_access` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node`.nid this record affects.',
  `gid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

--
-- Dumping data for table `jbqo_node_access`
--

INSERT INTO `jbqo_node_access` (`nid`, `gid`, `realm`, `grant_view`, `grant_update`, `grant_delete`) VALUES
(0, 0, 'all', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_node_comment_statistics`
--

CREATE TABLE `jbqo_node_comment_statistics` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node`.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_comment`.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT 0 COMMENT 'The Unix timestamp of the last comment that was posted within this node, from `jbqo_comment`.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from `jbqo_comment`.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT 0 COMMENT 'The user ID of the latest author to post a comment on this node, from `jbqo_comment`.uid.',
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The total number of comments on this node.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';

--
-- Dumping data for table `jbqo_node_comment_statistics`
--

INSERT INTO `jbqo_node_comment_statistics` (`nid`, `cid`, `last_comment_timestamp`, `last_comment_name`, `last_comment_uid`, `comment_count`) VALUES
(1, 0, 1608028764, NULL, 1, 0),
(2, 0, 1608029823, NULL, 1, 0),
(3, 0, 1608029911, NULL, 1, 0),
(4, 0, 1608029929, NULL, 1, 0),
(5, 0, 1608029945, NULL, 1, 0),
(6, 0, 1608029958, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_node_revision`
--

CREATE TABLE `jbqo_node_revision` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node` this version belongs to.',
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT 0 COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT 0 COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a `jbqo...';

--
-- Dumping data for table `jbqo_node_revision`
--

INSERT INTO `jbqo_node_revision` (`nid`, `vid`, `uid`, `title`, `log`, `timestamp`, `status`, `comment`, `promote`, `sticky`) VALUES
(1, 1, 1, 'Drupal test', '', 1608028764, 1, 2, 1, 0),
(2, 2, 1, 'Testing job 1', '', 1608029823, 1, 1, 0, 0),
(3, 3, 1, 'Testing job 2', '', 1608041774, 1, 1, 0, 0),
(4, 4, 1, 'Testing job 3', '', 1608037246, 1, 1, 0, 0),
(5, 5, 1, 'Testing job 4', '', 1608040768, 1, 1, 0, 0),
(6, 6, 1, 'Testing job 5', '', 1608029958, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_node_type`
--

CREATE TABLE `jbqo_node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a `jbqo_node` of this type.',
  `has_title` tinyint(3) UNSIGNED NOT NULL COMMENT 'Boolean indicating whether this type uses the `jbqo_node`.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined `jbqo_node` types.';

--
-- Dumping data for table `jbqo_node_type`
--

INSERT INTO `jbqo_node_type` (`type`, `name`, `base`, `module`, `description`, `help`, `has_title`, `title_label`, `custom`, `modified`, `locked`, `disabled`, `orig_type`) VALUES
('article', 'Article', 'node_content', 'node', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 1, 'Title', 1, 1, 0, 0, 'article'),
('job', 'Job', 'node_content', 'node', 'Create job entity', '', 1, 'Title', 1, 1, 0, 0, 'job'),
('page', 'Basic page', 'node_content', 'node', 'Use <em>basic pages</em> for your static content, such as an \'About us\' page.', '', 1, 'Title', 1, 1, 0, 0, 'page');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_queue`
--

CREATE TABLE `jbqo_queue` (
  `item_id` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob DEFAULT NULL COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp when the item was created.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_rdf_mapping`
--

CREATE TABLE `jbqo_rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob DEFAULT NULL COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';

--
-- Dumping data for table `jbqo_rdf_mapping`
--

INSERT INTO `jbqo_rdf_mapping` (`type`, `bundle`, `mapping`) VALUES
('node', 'article', 0x613a31313a7b733a31313a226669656c645f696d616765223b613a323a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a383a226f673a696d616765223b693a313b733a31323a22726466733a736565416c736f223b7d733a343a2274797065223b733a333a2272656c223b7d733a31303a226669656c645f74616773223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31303a2264633a7375626a656374223b7d733a343a2274797065223b733a333a2272656c223b7d733a373a2272646674797065223b613a323a7b693a303b733a393a2273696f633a4974656d223b693a313b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d),
('node', 'page', 0x613a393a7b733a373a2272646674797065223b613a313a7b693a303b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_registry`
--

CREATE TABLE `jbqo_registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

--
-- Dumping data for table `jbqo_registry`
--

INSERT INTO `jbqo_registry` (`name`, `type`, `filename`, `module`, `weight`) VALUES
('AccessDeniedTestCase', 'class', 'modules/system/system.test', 'system', 0),
('AdminMetaTagTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ArchiverInterface', 'interface', 'includes/archiver.inc', '', 0),
('ArchiverTar', 'class', 'modules/system/system.archiver.inc', 'system', 0),
('ArchiverZip', 'class', 'modules/system/system.archiver.inc', 'system', 0),
('Archive_Tar', 'class', 'modules/system/system.tar.inc', 'system', 0),
('BatchMemoryQueue', 'class', 'includes/batch.queue.inc', '', 0),
('BatchQueue', 'class', 'includes/batch.queue.inc', '', 0),
('BlockAdminThemeTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockCacheTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockHashTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockHiddenRegionTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockHTMLIdTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockInvalidRegionTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockTemplateSuggestionsUnitTest', 'class', 'modules/block/block.test', 'block', 0),
('BlockTestCase', 'class', 'modules/block/block.test', 'block', 0),
('BlockViewModuleDeltaAlterWebTest', 'class', 'modules/block/block.test', 'block', 0),
('ColorTestCase', 'class', 'modules/color/color.test', 'color', 0),
('CommentActionsTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentAnonymous', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentApprovalTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentBlockFunctionalTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentContentRebuild', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentController', 'class', 'modules/comment/comment.module', 'comment', 0),
('CommentFieldsTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentHelperCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentInterfaceTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentNodeAccessTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentNodeChangesTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentPagerTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentPreviewTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentRSSUnitTest', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentThreadingTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentTokenReplaceTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('CommentUninstallTestCase', 'class', 'modules/comment/comment.test', 'comment', 0),
('ConfirmFormTest', 'class', 'modules/system/system.test', 'system', 0),
('ContextualDynamicContextTestCase', 'class', 'modules/contextual/contextual.test', 'contextual', 0),
('CronQueueTestCase', 'class', 'modules/system/system.test', 'system', 0),
('CronRunTestCase', 'class', 'modules/system/system.test', 'system', 0),
('CtoolsContextIDTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/context.test', 'ctools', 0),
('CtoolsContextKeywordsSubstitutionTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/context.test', 'ctools', 0),
('CtoolsContextUnitTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/context.test', 'ctools', 0),
('CToolsCssCache', 'class', 'sites/all/modules/contrib/ctools/includes/css-cache.inc', 'ctools', 0),
('CtoolsCSSObjectCache', 'class', 'sites/all/modules/contrib/ctools/tests/css_cache.test', 'ctools', 0),
('CtoolsCssTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/css.test', 'ctools', 0),
('CtoolsMathExpressionStackTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/math_expression_stack.test', 'ctools', 0),
('CtoolsMathExpressionTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/math_expression.test', 'ctools', 0),
('CtoolsModuleTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/ctools.test', 'ctools', 0),
('CtoolsObjectCache', 'class', 'sites/all/modules/contrib/ctools/tests/object_cache.test', 'ctools', 0),
('CtoolsPageTokens', 'class', 'sites/all/modules/contrib/ctools/tests/page_tokens.test', 'ctools', 0),
('CtoolsPluginsGetInfoTestCase', 'class', 'sites/all/modules/contrib/ctools/tests/ctools.plugins.test', 'ctools', 0),
('CtoolsUnitObjectCachePlugins', 'class', 'sites/all/modules/contrib/ctools/tests/object_cache_unit.test', 'ctools', 0),
('ctools_context', 'class', 'sites/all/modules/contrib/ctools/includes/context.inc', 'ctools', 0),
('ctools_context_optional', 'class', 'sites/all/modules/contrib/ctools/includes/context.inc', 'ctools', 0),
('ctools_context_required', 'class', 'sites/all/modules/contrib/ctools/includes/context.inc', 'ctools', 0),
('ctools_export_ui', 'class', 'sites/all/modules/contrib/ctools/plugins/export_ui/ctools_export_ui.class.php', 'ctools', 0),
('ctools_math_expr', 'class', 'sites/all/modules/contrib/ctools/includes/math-expr.inc', 'ctools', 0),
('ctools_math_expr_stack', 'class', 'sites/all/modules/contrib/ctools/includes/math-expr.inc', 'ctools', 0),
('ctools_stylizer_image_processor', 'class', 'sites/all/modules/contrib/ctools/includes/stylizer.inc', 'ctools', 0),
('Database', 'class', 'includes/database/database.inc', '', 0),
('DatabaseCondition', 'class', 'includes/database/query.inc', '', 0),
('DatabaseConnection', 'class', 'includes/database/database.inc', '', 0),
('DatabaseConnectionNotDefinedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseConnection_mysql', 'class', 'includes/database/mysql/database.inc', '', 0),
('DatabaseConnection_pgsql', 'class', 'includes/database/pgsql/database.inc', '', 0),
('DatabaseConnection_sqlite', 'class', 'includes/database/sqlite/database.inc', '', 0),
('DatabaseDriverNotSpecifiedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseLog', 'class', 'includes/database/log.inc', '', 0),
('DatabaseSchema', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchemaObjectDoesNotExistException', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchemaObjectExistsException', 'class', 'includes/database/schema.inc', '', 0),
('DatabaseSchema_mysql', 'class', 'includes/database/mysql/schema.inc', '', 0),
('DatabaseSchema_pgsql', 'class', 'includes/database/pgsql/schema.inc', '', 0),
('DatabaseSchema_sqlite', 'class', 'includes/database/sqlite/schema.inc', '', 0),
('DatabaseStatementBase', 'class', 'includes/database/database.inc', '', 0),
('DatabaseStatementEmpty', 'class', 'includes/database/database.inc', '', 0),
('DatabaseStatementInterface', 'interface', 'includes/database/database.inc', '', 0),
('DatabaseStatementPrefetch', 'class', 'includes/database/prefetch.inc', '', 0),
('DatabaseStatement_sqlite', 'class', 'includes/database/sqlite/database.inc', '', 0),
('DatabaseTaskException', 'class', 'includes/install.inc', '', 0),
('DatabaseTasks', 'class', 'includes/install.inc', '', 0),
('DatabaseTasks_mysql', 'class', 'includes/database/mysql/install.inc', '', 0),
('DatabaseTasks_pgsql', 'class', 'includes/database/pgsql/install.inc', '', 0),
('DatabaseTasks_sqlite', 'class', 'includes/database/sqlite/install.inc', '', 0),
('DatabaseTransaction', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionCommitFailedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionExplicitCommitNotAllowedException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionNameNonUniqueException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionNoActiveException', 'class', 'includes/database/database.inc', '', 0),
('DatabaseTransactionOutOfOrderException', 'class', 'includes/database/database.inc', '', 0),
('DateFormatTestCase', 'class', 'modules/system/system.test', 'system', 0),
('DateTimeFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('DBLogTestCase', 'class', 'modules/dblog/dblog.test', 'dblog', 0),
('DefaultMailSystem', 'class', 'modules/system/system.mail.inc', 'system', 0),
('DeleteQuery', 'class', 'includes/database/query.inc', '', 0),
('DeleteQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('DevelMailLog', 'class', 'sites/all/modules/contrib/devel/devel.mail.inc', 'devel', 0),
('DevelMailTest', 'class', 'sites/all/modules/contrib/devel/devel.test', 'devel', 0),
('DrupalCacheArray', 'class', 'includes/bootstrap.inc', '', 0),
('DrupalCacheInterface', 'interface', 'includes/cache.inc', '', 0),
('DrupalDatabaseCache', 'class', 'includes/cache.inc', '', 0),
('DrupalDefaultEntityController', 'class', 'includes/entity.inc', '', 0),
('DrupalEntityControllerInterface', 'interface', 'includes/entity.inc', '', 0),
('DrupalFakeCache', 'class', 'includes/cache-install.inc', '', 0),
('DrupalLocalStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalPrivateStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalPublicStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('DrupalQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', 0),
('DrupalReliableQueueInterface', 'interface', 'modules/system/system.queue.inc', 'system', 0),
('DrupalRequestSanitizer', 'class', 'includes/request-sanitizer.inc', '', 0),
('DrupalSetMessageTest', 'class', 'modules/system/system.test', 'system', 0),
('DrupalStreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', 0),
('DrupalTemporaryStreamWrapper', 'class', 'includes/stream_wrappers.inc', '', 0),
('DrupalUpdateException', 'class', 'includes/update.inc', '', 0),
('DrupalUpdaterInterface', 'interface', 'includes/updater.inc', '', 0),
('EnableDisableTestCase', 'class', 'modules/system/system.test', 'system', 0),
('EntityFieldQuery', 'class', 'includes/entity.inc', '', 0),
('EntityFieldQueryException', 'class', 'includes/entity.inc', '', 0),
('EntityMalformedException', 'class', 'includes/entity.inc', '', 0),
('EntityPropertiesTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FeaturesCtoolsIntegrationTest', 'class', 'sites/all/modules/contrib/features/tests/features.test', 'features', 0),
('FeaturesDetectionTestCase', 'class', 'sites/all/modules/contrib/features/tests/features.test', 'features', 0),
('FeaturesEnableTestCase', 'class', 'sites/all/modules/contrib/features/tests/features.test', 'features', 0),
('FeaturesUserTestCase', 'class', 'sites/all/modules/contrib/features/tests/features.test', 'features', 0),
('FieldAttachOtherTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachStorageTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldAttachTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldBulkDeleteTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldDisplayAPITestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldException', 'class', 'modules/field/field.module', 'field', 0),
('FieldFormTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldInfo', 'class', 'modules/field/field.info.class.inc', 'field', 0),
('FieldInfoTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldInstanceCrudTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldsOverlapException', 'class', 'includes/database/database.inc', '', 0),
('FieldSqlStorageTestCase', 'class', 'modules/field/modules/field_sql_storage/field_sql_storage.test', 'field_sql_storage', 0),
('FieldTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldTranslationsTestCase', 'class', 'modules/field/tests/field.test', 'field', 0),
('FieldUIAlterTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUIManageDisplayTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUIManageFieldsTestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUITestCase', 'class', 'modules/field_ui/field_ui.test', 'field_ui', 0),
('FieldUpdateForbiddenException', 'class', 'modules/field/field.module', 'field', 0),
('FieldValidationException', 'class', 'modules/field/field.attach.inc', 'field', 0),
('FileFieldAnonymousSubmission', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldDisplayTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldPathTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldRevisionTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldValidateTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileFieldWidgetTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileManagedFileElementTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FilePrivateTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileScanDirectory', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTaxonomyTermTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTokenReplaceTestCase', 'class', 'modules/file/tests/file.test', 'file', 0),
('FileTransfer', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferChmodInterface', 'interface', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferException', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('FileTransferFTP', 'class', 'includes/filetransfer/ftp.inc', '', 0),
('FileTransferFTPExtension', 'class', 'includes/filetransfer/ftp.inc', '', 0),
('FileTransferLocal', 'class', 'includes/filetransfer/local.inc', '', 0),
('FileTransferSSH', 'class', 'includes/filetransfer/ssh.inc', '', 0),
('FilterAdminTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterCRUDTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterDefaultFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterDOMSerializeTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterFormatAccessTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterHooksTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterNoFormatTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterSecurityTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterSettingsTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FilterUnitTestCase', 'class', 'modules/filter/filter.test', 'filter', 0),
('FloodFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('FrontPageTestCase', 'class', 'modules/system/system.test', 'system', 0),
('HelpTestCase', 'class', 'modules/help/help.test', 'help', 0),
('HookRequirementsTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ImageAdminStylesUnitTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageAdminUiTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageDimensionsScaleTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageDimensionsTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageEffectsUnitTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldDefaultImagesTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldDisplayTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageFieldValidateTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageStyleFlushTest', 'class', 'modules/image/image.test', 'image', 0),
('ImageStylesPathAndUrlTestCase', 'class', 'modules/image/image.test', 'image', 0),
('ImageThemeFunctionWebTestCase', 'class', 'modules/image/image.test', 'image', 0),
('InfoFileParserTestCase', 'class', 'modules/system/system.test', 'system', 0),
('InsertQuery', 'class', 'includes/database/query.inc', '', 0),
('InsertQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('InsertQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', 0),
('InsertQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('InvalidMergeQueryException', 'class', 'includes/database/database.inc', '', 0),
('IPAddressBlockingTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ListDynamicValuesTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListDynamicValuesValidationTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListFieldTestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('ListFieldUITestCase', 'class', 'modules/field/modules/list/tests/list.test', 'list', 0),
('MailSystemInterface', 'interface', 'includes/mail.inc', '', 0),
('MemoryQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('MenuNodeTestCase', 'class', 'modules/menu/menu.test', 'menu', 0),
('MenuTestCase', 'class', 'modules/menu/menu.test', 'menu', 0),
('MergeQuery', 'class', 'includes/database/query.inc', '', 0),
('ModuleDependencyTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleRequiredTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleTestCase', 'class', 'modules/system/system.test', 'system', 0),
('ModuleUpdater', 'class', 'modules/system/system.updater.inc', 'system', 0),
('ModuleVersionTestCase', 'class', 'modules/system/system.test', 'system', 0),
('MultiStepNodeFormBasicOptionsTest', 'class', 'modules/node/node.test', 'node', 0),
('NewDefaultThemeBlocks', 'class', 'modules/block/block.test', 'block', 0),
('NodeAccessBaseTableTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessFieldTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessPagerTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessRebuildTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessRecordsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAccessTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeAdminTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeBlockFunctionalTest', 'class', 'modules/node/node.test', 'node', 0),
('NodeBlockTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeBuildContent', 'class', 'modules/node/node.test', 'node', 0),
('NodeController', 'class', 'modules/node/node.module', 'node', 0),
('NodeCreationTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeEntityFieldQueryAlter', 'class', 'modules/node/node.test', 'node', 0),
('NodeEntityViewModeAlterTest', 'class', 'modules/node/node.test', 'node', 0),
('NodeFeedTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeLoadHooksTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeLoadMultipleTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeMultiByteUtf8Test', 'class', 'modules/node/node.test', 'node', 0),
('NodePageCacheTest', 'class', 'modules/node/node.test', 'node', 0),
('NodePostSettingsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeQueryAlter', 'class', 'modules/node/node.test', 'node', 0),
('NodeRevisionPermissionsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeRevisionsTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeRSSContentTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeSaveTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTitleTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTitleXSSTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTokenReplaceTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTypePersistenceTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeTypeTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NodeWebTestCase', 'class', 'modules/node/node.test', 'node', 0),
('NoFieldsException', 'class', 'includes/database/database.inc', '', 0),
('NoHelpTestCase', 'class', 'modules/help/help.test', 'help', 0),
('NonDefaultBlockAdmin', 'class', 'modules/block/block.test', 'block', 0),
('NumberFieldTestCase', 'class', 'modules/field/modules/number/number.test', 'number', 0),
('OptionsSelectDynamicValuesTestCase', 'class', 'modules/field/modules/options/options.test', 'options', 0),
('OptionsWidgetsTestCase', 'class', 'modules/field/modules/options/options.test', 'options', 0),
('PageEditTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PageNotFoundTestCase', 'class', 'modules/system/system.test', 'system', 0),
('PagePreviewTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PagerDefault', 'class', 'includes/pager.inc', '', 0),
('PageTitleFiltering', 'class', 'modules/system/system.test', 'system', 0),
('PageViewTestCase', 'class', 'modules/node/node.test', 'node', 0),
('PathLanguageTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathLanguageUITestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathMonolingualTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathTaxonomyTermTestCase', 'class', 'modules/path/path.test', 'path', 0),
('PathTestCase', 'class', 'modules/path/path.test', 'path', 0),
('Query', 'class', 'includes/database/query.inc', '', 0),
('QueryAlterableInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueryConditionInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueryExtendableInterface', 'interface', 'includes/database/select.inc', '', 0),
('QueryPlaceholderInterface', 'interface', 'includes/database/query.inc', '', 0),
('QueueTestCase', 'class', 'modules/system/system.test', 'system', 0),
('RdfCommentAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfCrudTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfGetRdfNamespacesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfMappingDefinitionTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfMappingHookTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfRdfaMarkupTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RdfTrackerAttributesTestCase', 'class', 'modules/rdf/rdf.test', 'rdf', 0),
('RetrieveFileTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SchemaCache', 'class', 'includes/bootstrap.inc', '', 0),
('SearchAdvancedSearchForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchBlockTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchCommentCountToggleTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchCommentTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchConfigSettingsForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchEmbedForm', 'class', 'modules/search/search.test', 'search', 0),
('SearchExactTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchExcerptTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchExpressionInsertExtractTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchKeywordsConditions', 'class', 'modules/search/search.test', 'search', 0),
('SearchLanguageTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchMatchTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchNodeAccessTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchNodeTagTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchNumberMatchingTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchNumbersTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchPageOverride', 'class', 'modules/search/search.test', 'search', 0),
('SearchPageText', 'class', 'modules/search/search.test', 'search', 0),
('SearchQuery', 'class', 'modules/search/search.extender.inc', 'search', 0),
('SearchRankingTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchSetLocaleTest', 'class', 'modules/search/search.test', 'search', 0),
('SearchSimplifyTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SearchTokenizerTestCase', 'class', 'modules/search/search.test', 'search', 0),
('SelectQuery', 'class', 'includes/database/select.inc', '', 0),
('SelectQueryExtender', 'class', 'includes/database/select.inc', '', 0),
('SelectQueryInterface', 'interface', 'includes/database/select.inc', '', 0),
('SelectQuery_pgsql', 'class', 'includes/database/pgsql/select.inc', '', 0),
('SelectQuery_sqlite', 'class', 'includes/database/sqlite/select.inc', '', 0),
('ShortcutLinksTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShortcutSetsTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShortcutTestCase', 'class', 'modules/shortcut/shortcut.test', 'shortcut', 0),
('ShutdownFunctionsTest', 'class', 'modules/system/system.test', 'system', 0),
('SiteMaintenanceTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SkipDotsRecursiveDirectoryIterator', 'class', 'includes/filetransfer/filetransfer.inc', '', 0),
('StreamWrapperInterface', 'interface', 'includes/stream_wrappers.inc', '', 0),
('SummaryLengthTestCase', 'class', 'modules/node/node.test', 'node', 0),
('SystemAdminTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemAuthorizeCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemBlockTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemIndexPhpTest', 'class', 'modules/system/system.test', 'system', 0),
('SystemInfoAlterTestCase', 'class', 'modules/system/system.test', 'system', 0),
('SystemMainContentFallback', 'class', 'modules/system/system.test', 'system', 0),
('SystemQueue', 'class', 'modules/system/system.queue.inc', 'system', 0),
('SystemThemeFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('SystemValidTokenTest', 'class', 'modules/system/system.test', 'system', 0),
('TableSort', 'class', 'includes/tablesort.inc', '', 0),
('TaxonomyEFQTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyHooksTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyLegacyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyLoadMultipleTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyQueryAlterTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyRSSTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', 0),
('TaxonomyTermFieldMultipleVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermFieldTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermFunctionTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermIndexTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTermTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyThemeTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyTokenReplaceTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyVocabularyController', 'class', 'modules/taxonomy/taxonomy.module', 'taxonomy', 0),
('TaxonomyVocabularyFunctionalTest', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyVocabularyTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TaxonomyWebTestCase', 'class', 'modules/taxonomy/taxonomy.test', 'taxonomy', 0),
('TestingMailSystem', 'class', 'modules/system/system.mail.inc', 'system', 0),
('TextFieldTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('TextSummaryTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('TextTranslationTestCase', 'class', 'modules/field/modules/text/text.test', 'text', 0),
('ThemeRegistry', 'class', 'includes/theme.inc', '', 0),
('ThemeUpdater', 'class', 'modules/system/system.updater.inc', 'system', 0),
('TokenReplaceTestCase', 'class', 'modules/system/system.test', 'system', 0),
('TokenScanTest', 'class', 'modules/system/system.test', 'system', 0),
('TruncateQuery', 'class', 'includes/database/query.inc', '', 0),
('TruncateQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('TruncateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('UpdateCoreTestCase', 'class', 'modules/update/update.test', 'update', 0),
('UpdateCoreUnitTestCase', 'class', 'modules/update/update.test', 'update', 0),
('UpdateQuery', 'class', 'includes/database/query.inc', '', 0),
('UpdateQuery_mysql', 'class', 'includes/database/mysql/query.inc', '', 0),
('UpdateQuery_pgsql', 'class', 'includes/database/pgsql/query.inc', '', 0),
('UpdateQuery_sqlite', 'class', 'includes/database/sqlite/query.inc', '', 0),
('Updater', 'class', 'includes/updater.inc', '', 0),
('UpdaterException', 'class', 'includes/updater.inc', '', 0),
('UpdaterFileTransferException', 'class', 'includes/updater.inc', '', 0),
('UpdateScriptFunctionalTest', 'class', 'modules/system/system.test', 'system', 0),
('UpdateTestContribCase', 'class', 'modules/update/update.test', 'update', 0),
('UpdateTestHelper', 'class', 'modules/update/update.test', 'update', 0),
('UpdateTestUploadCase', 'class', 'modules/update/update.test', 'update', 0),
('UserAccountLinksUnitTests', 'class', 'modules/user/user.test', 'user', 0),
('UserAdminTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserAuthmapAssignmentTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserAutocompleteTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserBlocksUnitTests', 'class', 'modules/user/user.test', 'user', 0),
('UserCancelTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserController', 'class', 'modules/user/user.module', 'user', 0),
('UserCreateTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditedOwnAccountTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditRebuildTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserEditTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserLoginTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPasswordResetTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPermissionsTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserPictureTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRegistrationTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRoleAdminTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserRolesAssignmentTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserSaveTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserSignatureTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserTimeZoneFunctionalTest', 'class', 'modules/user/user.test', 'user', 0),
('UserTokenReplaceTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserUserSearchTestCase', 'class', 'modules/user/user.test', 'user', 0),
('UserValidateCurrentPassCustomForm', 'class', 'modules/user/user.test', 'user', 0),
('UserValidationTestCase', 'class', 'modules/user/user.test', 'user', 0),
('view', 'class', 'sites/all/modules/contrib/views/includes/view.inc', 'views', 0),
('ViewsAccessTest', 'class', 'sites/all/modules/contrib/views/tests/views_access.test', 'views', 0),
('ViewsAjaxTest', 'class', 'sites/all/modules/contrib/views/tests/views_ajax.test', 'views', 0),
('ViewsAnalyzeTest', 'class', 'sites/all/modules/contrib/views/tests/views_analyze.test', 'views', 0),
('ViewsArgumentDefaultTest', 'class', 'sites/all/modules/contrib/views/tests/views_argument_default.test', 'views', 0),
('ViewsArgumentValidatorTest', 'class', 'sites/all/modules/contrib/views/tests/views_argument_validator.test', 'views', 0),
('ViewsBasicTest', 'class', 'sites/all/modules/contrib/views/tests/views_basic.test', 'views', 0),
('ViewsCacheTest', 'class', 'sites/all/modules/contrib/views/tests/views_cache.test', 'views', 0),
('ViewsCloneTest', 'class', 'sites/all/modules/contrib/views/tests/views_clone.test', 'views', 0),
('ViewsExposedFormTest', 'class', 'sites/all/modules/contrib/views/tests/views_exposed_form.test', 'views', 0),
('viewsFieldApiDataTest', 'class', 'sites/all/modules/contrib/views/tests/field/views_fieldapi.test', 'views', 0),
('ViewsFieldApiTestHelper', 'class', 'sites/all/modules/contrib/views/tests/field/views_fieldapi.test', 'views', 0),
('ViewsGlossaryTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_glossary.test', 'views', 0),
('ViewsHandlerAreaTextTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_area_text.test', 'views', 0),
('viewsHandlerArgumentCommentUserUidTest', 'class', 'sites/all/modules/contrib/views/tests/comment/views_handler_argument_comment_user_uid.test', 'views', 0),
('ViewsHandlerArgumentNullTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_argument_null.test', 'views', 0),
('ViewsHandlerFieldBooleanTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_boolean.test', 'views', 0),
('ViewsHandlerFieldCustomTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_custom.test', 'views', 0),
('ViewsHandlerFieldDateTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_date.test', 'views', 0),
('viewsHandlerFieldFieldTest', 'class', 'sites/all/modules/contrib/views/tests/field/views_fieldapi.test', 'views', 0),
('ViewsHandlerFieldMath', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_math.test', 'views', 0),
('ViewsHandlerFieldTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field.test', 'views', 0),
('ViewsHandlerFieldUrlTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_url.test', 'views', 0),
('viewsHandlerFieldUserNameTest', 'class', 'sites/all/modules/contrib/views/tests/user/views_handler_field_user_name.test', 'views', 0),
('ViewsHandlerFileExtensionTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_extension.test', 'views', 0),
('ViewsHandlerFilterCombineTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_filter_combine.test', 'views', 0),
('viewsHandlerFilterCommentUserUidTest', 'class', 'sites/all/modules/contrib/views/tests/comment/views_handler_filter_comment_user_uid.test', 'views', 0),
('ViewsHandlerFilterCounterTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_counter.test', 'views', 0),
('ViewsHandlerFilterDateTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_filter_date.test', 'views', 0),
('ViewsHandlerFilterEqualityTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_filter_equality.test', 'views', 0),
('ViewsHandlerFilterInOperator', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_filter_in_operator.test', 'views', 0),
('ViewsHandlerFilterNumericTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_filter_numeric.test', 'views', 0),
('ViewsHandlerFilterStringTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_filter_string.test', 'views', 0),
('ViewsHandlerFilterTest', 'class', 'sites/all/modules/contrib/views/tests/views_handler_filter.test', 'views', 0),
('ViewsHandlerManyToOneTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_manytoone.test', 'views', 0),
('ViewsHandlerRelationshipNodeTermDataTest', 'class', 'sites/all/modules/contrib/views/tests/taxonomy/views_handler_relationship_node_term_data.test', 'views', 0),
('ViewsHandlerSortDateTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_sort_date.test', 'views', 0),
('ViewsHandlerSortRandomTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_sort_random.test', 'views', 0),
('ViewsHandlerSortTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_sort.test', 'views', 0),
('ViewsHandlersTest', 'class', 'sites/all/modules/contrib/views/tests/views_handlers.test', 'views', 0),
('ViewsHandlerTest', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handlers.test', 'views', 0),
('ViewsHandlerTestFileSize', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_size.test', 'views', 0),
('ViewsHandlerTestXss', 'class', 'sites/all/modules/contrib/views/tests/handlers/views_handler_field_xss.test', 'views', 0),
('ViewsModuleTest', 'class', 'sites/all/modules/contrib/views/tests/views_module.test', 'views', 0),
('ViewsNodeRevisionRelationsTestCase', 'class', 'sites/all/modules/contrib/views/tests/node/views_node_revision_relations.test', 'views', 0),
('ViewsPagerTest', 'class', 'sites/all/modules/contrib/views/tests/views_pager.test', 'views', 0),
('ViewsPluginDisplayTestCase', 'class', 'sites/all/modules/contrib/views/tests/plugins/views_plugin_display.test', 'views', 0),
('viewsPluginStyleJumpMenuTest', 'class', 'sites/all/modules/contrib/views/tests/styles/views_plugin_style_jump_menu.test', 'views', 0),
('ViewsPluginStyleMappingTest', 'class', 'sites/all/modules/contrib/views/tests/styles/views_plugin_style_mapping.test', 'views', 0),
('ViewsPluginStyleTestBase', 'class', 'sites/all/modules/contrib/views/tests/styles/views_plugin_style_base.test', 'views', 0),
('ViewsPluginStyleTestCase', 'class', 'sites/all/modules/contrib/views/tests/styles/views_plugin_style.test', 'views', 0),
('ViewsPluginStyleUnformattedTestCase', 'class', 'sites/all/modules/contrib/views/tests/styles/views_plugin_style_unformatted.test', 'views', 0),
('ViewsQueryGroupByTest', 'class', 'sites/all/modules/contrib/views/tests/views_groupby.test', 'views', 0),
('viewsSearchQuery', 'class', 'sites/all/modules/contrib/views/modules/search/views_handler_filter_search.inc', 'views', 0),
('ViewsSqlTest', 'class', 'sites/all/modules/contrib/views/tests/views_query.test', 'views', 0),
('ViewsTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_query.test', 'views', 0),
('ViewsTranslatableTest', 'class', 'sites/all/modules/contrib/views/tests/views_translatable.test', 'views', 0),
('ViewsUiBaseViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php', 'views_ui', 0),
('ViewsUiCommentViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_comment_views_wizard.class.php', 'views_ui', 0),
('ViewsUiFileManagedViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_file_managed_views_wizard.class.php', 'views_ui', 0),
('ViewsUiGroupbyTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_groupby.test', 'views', 0),
('ViewsUiNodeRevisionViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_revision_views_wizard.class.php', 'views_ui', 0),
('ViewsUiNodeViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_views_wizard.class.php', 'views_ui', 0),
('ViewsUiTaxonomyTermViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_taxonomy_term_views_wizard.class.php', 'views_ui', 0),
('ViewsUiUsersViewsWizard', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_users_views_wizard.class.php', 'views_ui', 0),
('ViewsUIWizardBasicTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardDefaultViewsTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardHelper', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardItemsPerPageTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardJumpMenuTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardMenuTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardOverrideDisplaysTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardSortingTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUIWizardTaggedWithTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_ui.test', 'views', 0),
('ViewsUpgradeTestCase', 'class', 'sites/all/modules/contrib/views/tests/views_upgrade.test', 'views', 0),
('ViewsUserArgumentDefault', 'class', 'sites/all/modules/contrib/views/tests/user/views_user_argument_default.test', 'views', 0),
('ViewsUserArgumentValidate', 'class', 'sites/all/modules/contrib/views/tests/user/views_user_argument_validate.test', 'views', 0),
('ViewsUserTestCase', 'class', 'sites/all/modules/contrib/views/tests/user/views_user.test', 'views', 0),
('ViewsViewTest', 'class', 'sites/all/modules/contrib/views/tests/views_view.test', 'views', 0),
('ViewsWizardException', 'class', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php', 'views_ui', 0),
('ViewsWizardInterface', 'interface', 'sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php', 'views_ui', 0),
('views_db_object', 'class', 'sites/all/modules/contrib/views/includes/view.inc', 'views', 0),
('views_display', 'class', 'sites/all/modules/contrib/views/includes/view.inc', 'views', 0),
('views_handler', 'class', 'sites/all/modules/contrib/views/includes/handlers.inc', 'views', 0),
('views_handler_area', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area.inc', 'views', 0),
('views_handler_area_broken', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area.inc', 'views', 0),
('views_handler_area_messages', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area_messages.inc', 'views', 0),
('views_handler_area_result', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area_result.inc', 'views', 0),
('views_handler_area_text', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area_text.inc', 'views', 0),
('views_handler_area_text_custom', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area_text_custom.inc', 'views', 0),
('views_handler_area_view', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_area_view.inc', 'views', 0),
('views_handler_argument', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument.inc', 'views', 0),
('views_handler_argument_aggregator_category_cid', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_category_cid.inc', 'views', 0),
('views_handler_argument_aggregator_fid', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_fid.inc', 'views', 0),
('views_handler_argument_aggregator_iid', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_iid.inc', 'views', 0),
('views_handler_argument_broken', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument.inc', 'views', 0),
('views_handler_argument_comment_user_uid', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_argument_comment_user_uid.inc', 'views', 0),
('views_handler_argument_date', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_date.inc', 'views', 0),
('views_handler_argument_field_list', 'class', 'sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list.inc', 'views', 0),
('views_handler_argument_field_list_string', 'class', 'sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list_string.inc', 'views', 0),
('views_handler_argument_file_fid', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_argument_file_fid.inc', 'views', 0),
('views_handler_argument_formula', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_formula.inc', 'views', 0),
('views_handler_argument_group_by_numeric', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_group_by_numeric.inc', 'views', 0),
('views_handler_argument_locale_group', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_group.inc', 'views', 0),
('views_handler_argument_locale_language', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_language.inc', 'views', 0),
('views_handler_argument_many_to_one', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_many_to_one.inc', 'views', 0),
('views_handler_argument_node_created_day', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', 'views', 0),
('views_handler_argument_node_created_fulldate', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', 'views', 0),
('views_handler_argument_node_created_month', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', 'views', 0),
('views_handler_argument_node_created_week', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', 'views', 0),
('views_handler_argument_node_created_year', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', 'views', 0),
('views_handler_argument_node_created_year_month', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', 'views', 0),
('views_handler_argument_node_language', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_node_language.inc', 'views', 0),
('views_handler_argument_node_nid', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_node_nid.inc', 'views', 0),
('views_handler_argument_node_tnid', 'class', 'sites/all/modules/contrib/views/modules/translation/views_handler_argument_node_tnid.inc', 'views', 0),
('views_handler_argument_node_type', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_node_type.inc', 'views', 0),
('views_handler_argument_node_uid_revision', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_node_uid_revision.inc', 'views', 0),
('views_handler_argument_node_vid', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_argument_node_vid.inc', 'views', 0),
('views_handler_argument_null', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_null.inc', 'views', 0),
('views_handler_argument_numeric', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_numeric.inc', 'views', 0),
('views_handler_argument_search', 'class', 'sites/all/modules/contrib/views/modules/search/views_handler_argument_search.inc', 'views', 0),
('views_handler_argument_string', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_argument_string.inc', 'views', 0),
('views_handler_argument_taxonomy', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_taxonomy.inc', 'views', 0),
('views_handler_argument_term_node_tid', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid.inc', 'views', 0),
('views_handler_argument_term_node_tid_depth', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth.inc', 'views', 0),
('views_handler_argument_term_node_tid_depth_join', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc', 'views', 0),
('views_handler_argument_term_node_tid_depth_modifier', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc', 'views', 0),
('views_handler_argument_tracker_comment_user_uid', 'class', 'sites/all/modules/contrib/views/modules/tracker/views_handler_argument_tracker_comment_user_uid.inc', 'views', 0),
('views_handler_argument_users_roles_rid', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_argument_users_roles_rid.inc', 'views', 0),
('views_handler_argument_user_uid', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_argument_user_uid.inc', 'views', 0),
('views_handler_argument_vocabulary_machine_name', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc', 'views', 0),
('views_handler_argument_vocabulary_vid', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_vid.inc', 'views', 0),
('views_handler_field', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field.inc', 'views', 0),
('views_handler_field_accesslog_path', 'class', 'sites/all/modules/contrib/views/modules/statistics/views_handler_field_accesslog_path.inc', 'views', 0),
('views_handler_field_aggregator_category', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_category.inc', 'views', 0),
('views_handler_field_aggregator_title_link', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_title_link.inc', 'views', 0),
('views_handler_field_aggregator_xss', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_xss.inc', 'views', 0),
('views_handler_field_boolean', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_boolean.inc', 'views', 0),
('views_handler_field_broken', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field.inc', 'views', 0),
('views_handler_field_comment', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment.inc', 'views', 0),
('views_handler_field_comment_depth', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_depth.inc', 'views', 0),
('views_handler_field_comment_link', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link.inc', 'views', 0),
('views_handler_field_comment_link_approve', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_approve.inc', 'views', 0),
('views_handler_field_comment_link_delete', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_delete.inc', 'views', 0),
('views_handler_field_comment_link_edit', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_edit.inc', 'views', 0),
('views_handler_field_comment_link_reply', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_reply.inc', 'views', 0);
INSERT INTO `jbqo_registry` (`name`, `type`, `filename`, `module`, `weight`) VALUES
('views_handler_field_comment_node_link', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_node_link.inc', 'views', 0),
('views_handler_field_comment_username', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_username.inc', 'views', 0),
('views_handler_field_contact_link', 'class', 'sites/all/modules/contrib/views/modules/contact/views_handler_field_contact_link.inc', 'views', 0),
('views_handler_field_contextual_links', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_contextual_links.inc', 'views', 0),
('views_handler_field_counter', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_counter.inc', 'views', 0),
('views_handler_field_ctools_dropdown', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_ctools_dropdown.inc', 'views', 0),
('views_handler_field_custom', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_custom.inc', 'views', 0),
('views_handler_field_date', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_date.inc', 'views', 0),
('views_handler_field_entity', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_entity.inc', 'views', 0),
('views_handler_field_field', 'class', 'sites/all/modules/contrib/views/modules/field/views_handler_field_field.inc', 'views', 0),
('views_handler_field_file', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_field_file.inc', 'views', 0),
('views_handler_field_file_extension', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_field_file_extension.inc', 'views', 0),
('views_handler_field_file_filemime', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_field_file_filemime.inc', 'views', 0),
('views_handler_field_file_size', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field.inc', 'views', 0),
('views_handler_field_file_status', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_field_file_status.inc', 'views', 0),
('views_handler_field_file_uri', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_field_file_uri.inc', 'views', 0),
('views_handler_field_filter_format_name', 'class', 'sites/all/modules/contrib/views/modules/filter/views_handler_field_filter_format_name.inc', 'views', 0),
('views_handler_field_history_user_timestamp', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_history_user_timestamp.inc', 'views', 0),
('views_handler_field_last_comment_timestamp', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_last_comment_timestamp.inc', 'views', 0),
('views_handler_field_links', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_links.inc', 'views', 0),
('views_handler_field_locale_group', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_group.inc', 'views', 0),
('views_handler_field_locale_language', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_language.inc', 'views', 0),
('views_handler_field_locale_link_edit', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_link_edit.inc', 'views', 0),
('views_handler_field_machine_name', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_machine_name.inc', 'views', 0),
('views_handler_field_markup', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_markup.inc', 'views', 0),
('views_handler_field_math', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_math.inc', 'views', 0),
('views_handler_field_ncs_last_comment_name', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_comment_name.inc', 'views', 0),
('views_handler_field_ncs_last_updated', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_updated.inc', 'views', 0),
('views_handler_field_node', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node.inc', 'views', 0),
('views_handler_field_node_comment', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_node_comment.inc', 'views', 0),
('views_handler_field_node_counter_timestamp', 'class', 'sites/all/modules/contrib/views/modules/statistics/views_handler_field_node_counter_timestamp.inc', 'views', 0),
('views_handler_field_node_language', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_field_node_language.inc', 'views', 0),
('views_handler_field_node_link', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_link.inc', 'views', 0),
('views_handler_field_node_link_delete', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_delete.inc', 'views', 0),
('views_handler_field_node_link_edit', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_edit.inc', 'views', 0),
('views_handler_field_node_link_translate', 'class', 'sites/all/modules/contrib/views/modules/translation/views_handler_field_node_link_translate.inc', 'views', 0),
('views_handler_field_node_new_comments', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_field_node_new_comments.inc', 'views', 0),
('views_handler_field_node_path', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_path.inc', 'views', 0),
('views_handler_field_node_revision', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision.inc', 'views', 0),
('views_handler_field_node_revision_link', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link.inc', 'views', 0),
('views_handler_field_node_revision_link_delete', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_delete.inc', 'views', 0),
('views_handler_field_node_revision_link_revert', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_revert.inc', 'views', 0),
('views_handler_field_node_translation_link', 'class', 'sites/all/modules/contrib/views/modules/translation/views_handler_field_node_translation_link.inc', 'views', 0),
('views_handler_field_node_type', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_type.inc', 'views', 0),
('views_handler_field_node_version_count', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_field_node_version_count.inc', 'views', 0),
('views_handler_field_numeric', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_numeric.inc', 'views', 0),
('views_handler_field_prerender_list', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_prerender_list.inc', 'views', 0),
('views_handler_field_profile_date', 'class', 'sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_date.inc', 'views', 0),
('views_handler_field_profile_list', 'class', 'sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_list.inc', 'views', 0),
('views_handler_field_search_score', 'class', 'sites/all/modules/contrib/views/modules/search/views_handler_field_search_score.inc', 'views', 0),
('views_handler_field_serialized', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_serialized.inc', 'views', 0),
('views_handler_field_statistics_numeric', 'class', 'sites/all/modules/contrib/views/modules/statistics/views_handler_field_statistics_numeric.inc', 'views', 0),
('views_handler_field_taxonomy', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_taxonomy.inc', 'views', 0),
('views_handler_field_term_link_edit', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_link_edit.inc', 'views', 0),
('views_handler_field_term_node_tid', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_node_tid.inc', 'views', 0),
('views_handler_field_time_interval', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_time_interval.inc', 'views', 0),
('views_handler_field_url', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field_url.inc', 'views', 0),
('views_handler_field_user', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user.inc', 'views', 0),
('views_handler_field_user_language', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_language.inc', 'views', 0),
('views_handler_field_user_link', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_link.inc', 'views', 0),
('views_handler_field_user_link_cancel', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_cancel.inc', 'views', 0),
('views_handler_field_user_link_edit', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_edit.inc', 'views', 0),
('views_handler_field_user_mail', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_mail.inc', 'views', 0),
('views_handler_field_user_name', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_name.inc', 'views', 0),
('views_handler_field_user_permissions', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_permissions.inc', 'views', 0),
('views_handler_field_user_picture', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_picture.inc', 'views', 0),
('views_handler_field_user_roles', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_field_user_roles.inc', 'views', 0),
('views_handler_field_xss', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_field.inc', 'views', 0),
('views_handler_filter', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter.inc', 'views', 0),
('views_handler_filter_aggregator_category_cid', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_handler_filter_aggregator_category_cid.inc', 'views', 0),
('views_handler_filter_boolean_operator', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator.inc', 'views', 0),
('views_handler_filter_boolean_operator_string', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator_string.inc', 'views', 0),
('views_handler_filter_broken', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter.inc', 'views', 0),
('views_handler_filter_combine', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_combine.inc', 'views', 0),
('views_handler_filter_comment_user_uid', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_filter_comment_user_uid.inc', 'views', 0),
('views_handler_filter_date', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_date.inc', 'views', 0),
('views_handler_filter_entity_bundle', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_entity_bundle.inc', 'views', 0),
('views_handler_filter_equality', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_equality.inc', 'views', 0),
('views_handler_filter_fields_compare', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_fields_compare.inc', 'views', 0),
('views_handler_filter_field_list', 'class', 'sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list.inc', 'views', 0),
('views_handler_filter_field_list_boolean', 'class', 'sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list_boolean.inc', 'views', 0),
('views_handler_filter_file_status', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_filter_file_status.inc', 'views', 0),
('views_handler_filter_group_by_numeric', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_group_by_numeric.inc', 'views', 0),
('views_handler_filter_history_user_timestamp', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_filter_history_user_timestamp.inc', 'views', 0),
('views_handler_filter_in_operator', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_in_operator.inc', 'views', 0),
('views_handler_filter_locale_group', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_group.inc', 'views', 0),
('views_handler_filter_locale_language', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_language.inc', 'views', 0),
('views_handler_filter_locale_version', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_version.inc', 'views', 0),
('views_handler_filter_many_to_one', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_many_to_one.inc', 'views', 0),
('views_handler_filter_ncs_last_updated', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_filter_ncs_last_updated.inc', 'views', 0),
('views_handler_filter_node_access', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_filter_node_access.inc', 'views', 0),
('views_handler_filter_node_comment', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_filter_node_comment.inc', 'views', 0),
('views_handler_filter_node_language', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_filter_node_language.inc', 'views', 0),
('views_handler_filter_node_status', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_filter_node_status.inc', 'views', 0),
('views_handler_filter_node_tnid', 'class', 'sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid.inc', 'views', 0),
('views_handler_filter_node_tnid_child', 'class', 'sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid_child.inc', 'views', 0),
('views_handler_filter_node_type', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_filter_node_type.inc', 'views', 0),
('views_handler_filter_node_uid_revision', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_filter_node_uid_revision.inc', 'views', 0),
('views_handler_filter_node_version_count', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_filter_node_version_count.inc', 'views', 0),
('views_handler_filter_numeric', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_numeric.inc', 'views', 0),
('views_handler_filter_profile_selection', 'class', 'sites/all/modules/contrib/views/modules/profile/views_handler_filter_profile_selection.inc', 'views', 0),
('views_handler_filter_search', 'class', 'sites/all/modules/contrib/views/modules/search/views_handler_filter_search.inc', 'views', 0),
('views_handler_filter_string', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_filter_string.inc', 'views', 0),
('views_handler_filter_system_type', 'class', 'sites/all/modules/contrib/views/modules/system/views_handler_filter_system_type.inc', 'views', 0),
('views_handler_filter_term_node_tid', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid.inc', 'views', 0),
('views_handler_filter_term_node_tid_depth', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth.inc', 'views', 0),
('views_handler_filter_term_node_tid_depth_join', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc', 'views', 0),
('views_handler_filter_tracker_boolean_operator', 'class', 'sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_boolean_operator.inc', 'views', 0),
('views_handler_filter_tracker_comment_user_uid', 'class', 'sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_comment_user_uid.inc', 'views', 0),
('views_handler_filter_user_current', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_filter_user_current.inc', 'views', 0),
('views_handler_filter_user_name', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_filter_user_name.inc', 'views', 0),
('views_handler_filter_user_permissions', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_filter_user_permissions.inc', 'views', 0),
('views_handler_filter_user_roles', 'class', 'sites/all/modules/contrib/views/modules/user/views_handler_filter_user_roles.inc', 'views', 0),
('views_handler_filter_vocabulary_machine_name', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc', 'views', 0),
('views_handler_filter_vocabulary_vid', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_vid.inc', 'views', 0),
('views_handler_relationship', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_relationship.inc', 'views', 0),
('views_handler_relationship_broken', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_relationship.inc', 'views', 0),
('views_handler_relationship_entity_reverse', 'class', 'sites/all/modules/contrib/views/modules/field/views_handler_relationship_entity_reverse.inc', 'views', 0),
('views_handler_relationship_groupwise_max', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_relationship_groupwise_max.inc', 'views', 0),
('views_handler_relationship_node_term_data', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_handler_relationship_node_term_data.inc', 'views', 0),
('views_handler_relationship_translation', 'class', 'sites/all/modules/contrib/views/modules/translation/views_handler_relationship_translation.inc', 'views', 0),
('views_handler_sort', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_sort.inc', 'views', 0),
('views_handler_sort_broken', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_sort.inc', 'views', 0),
('views_handler_sort_comment_thread', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_sort_comment_thread.inc', 'views', 0),
('views_handler_sort_date', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_sort_date.inc', 'views', 0),
('views_handler_sort_group_by_numeric', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_sort_group_by_numeric.inc', 'views', 0),
('views_handler_sort_menu_hierarchy', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_sort_menu_hierarchy.inc', 'views', 0),
('views_handler_sort_ncs_last_comment_name', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_comment_name.inc', 'views', 0),
('views_handler_sort_ncs_last_updated', 'class', 'sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_updated.inc', 'views', 0),
('views_handler_sort_node_language', 'class', 'sites/all/modules/contrib/views/modules/locale/views_handler_sort_node_language.inc', 'views', 0),
('views_handler_sort_node_version_count', 'class', 'sites/all/modules/contrib/views/modules/node/views_handler_sort_node_version_count.inc', 'views', 0),
('views_handler_sort_random', 'class', 'sites/all/modules/contrib/views/handlers/views_handler_sort_random.inc', 'views', 0),
('views_handler_sort_search_score', 'class', 'sites/all/modules/contrib/views/modules/search/views_handler_sort_search_score.inc', 'views', 0),
('views_join', 'class', 'sites/all/modules/contrib/views/includes/handlers.inc', 'views', 0),
('views_join_subquery', 'class', 'sites/all/modules/contrib/views/includes/handlers.inc', 'views', 0),
('views_many_to_one_helper', 'class', 'sites/all/modules/contrib/views/includes/handlers.inc', 'views', 0),
('views_object', 'class', 'sites/all/modules/contrib/views/includes/base.inc', 'views', 0),
('views_plugin', 'class', 'sites/all/modules/contrib/views/includes/plugins.inc', 'views', 0),
('views_plugin_access', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_access.inc', 'views', 0),
('views_plugin_access_none', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_access_none.inc', 'views', 0),
('views_plugin_access_perm', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_access_perm.inc', 'views', 0),
('views_plugin_access_role', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_access_role.inc', 'views', 0),
('views_plugin_argument_default', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_default.inc', 'views', 0),
('views_plugin_argument_default_book_root', 'class', 'sites/all/modules/contrib/views/modules/book/views_plugin_argument_default_book_root.inc', 'views', 0),
('views_plugin_argument_default_current_user', 'class', 'sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_current_user.inc', 'views', 0),
('views_plugin_argument_default_fixed', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_default_fixed.inc', 'views', 0),
('views_plugin_argument_default_node', 'class', 'sites/all/modules/contrib/views/modules/node/views_plugin_argument_default_node.inc', 'views', 0),
('views_plugin_argument_default_php', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_default_php.inc', 'views', 0),
('views_plugin_argument_default_raw', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_default_raw.inc', 'views', 0),
('views_plugin_argument_default_taxonomy_tid', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc', 'views', 0),
('views_plugin_argument_default_user', 'class', 'sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_user.inc', 'views', 0),
('views_plugin_argument_validate', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_validate.inc', 'views', 0),
('views_plugin_argument_validate_node', 'class', 'sites/all/modules/contrib/views/modules/node/views_plugin_argument_validate_node.inc', 'views', 0),
('views_plugin_argument_validate_numeric', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_numeric.inc', 'views', 0),
('views_plugin_argument_validate_php', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_php.inc', 'views', 0),
('views_plugin_argument_validate_taxonomy_term', 'class', 'sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc', 'views', 0),
('views_plugin_argument_validate_user', 'class', 'sites/all/modules/contrib/views/modules/user/views_plugin_argument_validate_user.inc', 'views', 0),
('views_plugin_cache', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_cache.inc', 'views', 0),
('views_plugin_cache_none', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_cache_none.inc', 'views', 0),
('views_plugin_cache_time', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_cache_time.inc', 'views', 0),
('views_plugin_display', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display.inc', 'views', 0),
('views_plugin_display_attachment', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_attachment.inc', 'views', 0),
('views_plugin_display_block', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_block.inc', 'views', 0),
('views_plugin_display_default', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_default.inc', 'views', 0),
('views_plugin_display_embed', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_embed.inc', 'views', 0),
('views_plugin_display_extender', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_extender.inc', 'views', 0),
('views_plugin_display_feed', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_feed.inc', 'views', 0),
('views_plugin_display_page', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_display_page.inc', 'views', 0),
('views_plugin_exposed_form', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_exposed_form.inc', 'views', 0),
('views_plugin_exposed_form_basic', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_basic.inc', 'views', 0),
('views_plugin_exposed_form_input_required', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_input_required.inc', 'views', 0),
('views_plugin_localization', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_localization.inc', 'views', 0),
('views_plugin_localization_core', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_localization_core.inc', 'views', 0),
('views_plugin_localization_none', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_localization_none.inc', 'views', 0),
('views_plugin_localization_test', 'class', 'sites/all/modules/contrib/views/tests/views_plugin_localization_test.inc', 'views', 0),
('views_plugin_pager', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_pager.inc', 'views', 0),
('views_plugin_pager_full', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_pager_full.inc', 'views', 0),
('views_plugin_pager_mini', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_pager_mini.inc', 'views', 0),
('views_plugin_pager_none', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_pager_none.inc', 'views', 0),
('views_plugin_pager_some', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_pager_some.inc', 'views', 0),
('views_plugin_query', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_query.inc', 'views', 0),
('views_plugin_query_default', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_query_default.inc', 'views', 0),
('views_plugin_row', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_row.inc', 'views', 0),
('views_plugin_row_aggregator_rss', 'class', 'sites/all/modules/contrib/views/modules/aggregator/views_plugin_row_aggregator_rss.inc', 'views', 0),
('views_plugin_row_comment_rss', 'class', 'sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_rss.inc', 'views', 0),
('views_plugin_row_comment_view', 'class', 'sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_view.inc', 'views', 0),
('views_plugin_row_fields', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_row_fields.inc', 'views', 0),
('views_plugin_row_node_rss', 'class', 'sites/all/modules/contrib/views/modules/node/views_plugin_row_node_rss.inc', 'views', 0),
('views_plugin_row_node_view', 'class', 'sites/all/modules/contrib/views/modules/node/views_plugin_row_node_view.inc', 'views', 0),
('views_plugin_row_rss_fields', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_row_rss_fields.inc', 'views', 0),
('views_plugin_row_search_view', 'class', 'sites/all/modules/contrib/views/modules/search/views_plugin_row_search_view.inc', 'views', 0),
('views_plugin_row_user_view', 'class', 'sites/all/modules/contrib/views/modules/user/views_plugin_row_user_view.inc', 'views', 0),
('views_plugin_style', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style.inc', 'views', 0),
('views_plugin_style_default', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_default.inc', 'views', 0),
('views_plugin_style_grid', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_grid.inc', 'views', 0),
('views_plugin_style_jump_menu', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_jump_menu.inc', 'views', 0),
('views_plugin_style_list', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_list.inc', 'views', 0),
('views_plugin_style_mapping', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_mapping.inc', 'views', 0),
('views_plugin_style_rss', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_rss.inc', 'views', 0),
('views_plugin_style_summary', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_summary.inc', 'views', 0),
('views_plugin_style_summary_jump_menu', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_summary_jump_menu.inc', 'views', 0),
('views_plugin_style_summary_unformatted', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_summary_unformatted.inc', 'views', 0),
('views_plugin_style_table', 'class', 'sites/all/modules/contrib/views/plugins/views_plugin_style_table.inc', 'views', 0),
('views_test_area_access', 'class', 'sites/all/modules/contrib/views/tests/test_handlers/views_test_area_access.inc', 'views', 0),
('views_test_plugin_access_test_dynamic', 'class', 'sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_dynamic.inc', 'views', 0),
('views_test_plugin_access_test_static', 'class', 'sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_static.inc', 'views', 0),
('views_test_plugin_style_test_mapping', 'class', 'sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_style_test_mapping.inc', 'views', 0),
('views_ui', 'class', 'sites/all/modules/contrib/views/plugins/export_ui/views_ui.class.php', 'views_ui', 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_registry_file`
--

CREATE TABLE `jbqo_registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

--
-- Dumping data for table `jbqo_registry_file`
--

INSERT INTO `jbqo_registry_file` (`filename`, `hash`) VALUES
('includes/actions.inc', 'f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759'),
('includes/ajax.inc', '8d5ebead219c48d5929ee6a5a178a331471ee6ceb38653094514c952457eaebd'),
('includes/archiver.inc', 'bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9'),
('includes/authorize.inc', '6d64d8c21aa01eb12fc29918732e4df6b871ed06e5d41373cb95c197ed661d13'),
('includes/batch.inc', '3480548cff18a67cf26072e041058cabe64bb839c6320a9050dc32eb87534aef'),
('includes/batch.queue.inc', '554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f'),
('includes/bootstrap.inc', 'dc09fa65a08e5cf64980ff59bbca0252549dbbbdde1a6b6619109526316351b6'),
('includes/cache-install.inc', 'e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e'),
('includes/cache.inc', '033c9bf2555dba29382b077f78cc00c82fd7f42a959ba31b710adddf6fdf24fe'),
('includes/common.inc', 'ae34badd3f77d27fc9e4eddc5cc48d657fc8701313bb8a176eac808524e3ddb2'),
('includes/database/database.inc', '3b90b8ebf834894f075cfd9d135076679bc6677c4b73b7441550ac217a0010dc'),
('includes/database/log.inc', '9feb5a17ae2fabcf26a96d2a634ba73da501f7bcfc3599a693d916a6971d00d1'),
('includes/database/mysql/database.inc', '6dded0be670ce06b00b30e7c226224ecf344adb90c98af120c052ca6d8a80ac0'),
('includes/database/mysql/install.inc', '6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0'),
('includes/database/mysql/query.inc', 'cddf695f7dbd483591f93af805e7118a04eac3f21c0105326642c6463587670c'),
('includes/database/mysql/schema.inc', 'c34aa7b7d2cb4662965497ff86f242224116bbd9b72ca6287c12039a65feb72e'),
('includes/database/pgsql/database.inc', '651bec324e2204aa35a28fdbd876aa8e4f7a9e909e75cc8db811e9c156b0df88'),
('includes/database/pgsql/install.inc', '39587f26a9e054afaab2064d996af910f1b201ef1c6b82938ef130e4ff8c6aab'),
('includes/database/pgsql/query.inc', '0df57377686c921e722a10b49d5e433b131176c8059a4ace4680964206fc14b4'),
('includes/database/pgsql/schema.inc', '1588daadfa53506aa1f5d94572162a45a46dc3ceabdd0e2f224532ded6508403'),
('includes/database/pgsql/select.inc', '1e509bc97c58223750e8ea735145b316827e36f43c07b946003e41f5bca23659'),
('includes/database/prefetch.inc', 'b5b207a66a69ecb52ee4f4459af16a7b5eabedc87254245f37cc33bebb61c0fb'),
('includes/database/query.inc', '982d44a294eea1c9619687c14df2987257e3776fcabeba05f01432e934cf61c6'),
('includes/database/schema.inc', 'da9d48f26c3a47a91f1eb2fa216e9deab2ec42ba10c76039623ce7b6bc984a06'),
('includes/database/select.inc', 'ffb07459c3276d9bd05edec7c1c9ebf192bcb9dfdaa176c362cd91ea01f64d93'),
('includes/database/sqlite/database.inc', '29f3af120e90b3a3b6d6623bde5fc669860a9730765d147ac6fd922a7c400043'),
('includes/database/sqlite/install.inc', '6620f354aa175a116ba3a0562c980d86cc3b8b481042fc3cc5ed6a4d1a7a6d74'),
('includes/database/sqlite/query.inc', '5d4dc3ac34cb2dbc0293471e85e37c890da3da6cd8c0c540c6f33313e4c0cbe9'),
('includes/database/sqlite/schema.inc', '223f150f314374835c636ba3ada9a1ccd5159a6e09adfc22570953c3c4d855e2'),
('includes/database/sqlite/select.inc', '8d1c426dbd337733c206cce9f59a172546c6ed856d8ef3f1c7bef05a16f7bf68'),
('includes/date.inc', '1de2c25e3b67a9919fc6c8061594442b6fb2cdd3a48ddf1591ee3aa98484b737'),
('includes/entity.inc', 'f06b508f93e72ba70f979d8391be57662c018a03a32fac0a6d3baa752740133d'),
('includes/errors.inc', 'd731bbe3a60508e164cfa90b8edc06400c7f15844f9f9bc3935dd87e44c460db'),
('includes/file.inc', '8c4b185c5805ee811e7d6292e2924de24ebf30080f74c173bf8d5cc771c4fff6'),
('includes/file.mimetypes.inc', '33266e837f4ce076378e7e8cef6c5af46446226ca4259f83e13f605856a7f147'),
('includes/file.phar.inc', '544df23f736ce49f458033d6515a301a8ca1c7a7d1bfd3f388caef910534abb3'),
('includes/filetransfer/filetransfer.inc', '68442c03fd8612297a0d1ab86437ff9072fe1b71516f4c1e9f581d137a774698'),
('includes/filetransfer/ftp.inc', '51eb119b8e1221d598ffa6cc46c8a322aa77b49a3d8879f7fb38b7221cf7e06d'),
('includes/filetransfer/local.inc', '7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492'),
('includes/filetransfer/ssh.inc', '92f1232158cb32ab04cbc93ae38ad3af04796e18f66910a9bc5ca8e437f06891'),
('includes/form.inc', '0900d375a3e620d9c78995c7836b98d73ec125942a650e741667bbd14fc86b2a'),
('includes/graph.inc', '8e0e313a8bb33488f371df11fc1b58d7cf80099b886cd1003871e2c896d1b536'),
('includes/image.inc', 'bcdc7e1599c02227502b9d0fe36eeb2b529b130a392bc709eb737647bd361826'),
('includes/install.core.inc', '189653e4bb7d4828bd6e1b61015fabcc7182e23d9dd8858170f98114d99400c8'),
('includes/install.inc', '4d0b8c1532a8829051e17f275fa27e9c379ab826aee2e27229a9679ea6775da7'),
('includes/iso.inc', '0ce4c225edcfa9f037703bc7dd09d4e268a69bcc90e55da0a3f04c502bd2f349'),
('includes/json-encode.inc', '02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e'),
('includes/language.inc', '4e08f30843a7ccaeea5c041083e9f77d33d57ff002f1ab4f66168e2c683ce128'),
('includes/locale.inc', 'ca50acc0780cbffeca17f99a0997f91b8b9402f0eec1898c3122e1d73664d01d'),
('includes/lock.inc', 'a181c8bd4f88d292a0a73b9f1fbd727e3314f66ec3631f288e6b9a54ba2b70fa'),
('includes/mail.inc', 'a7bef724e057f7410e42c8f33b00c9a0246a2ca2e856a113c9e20eecc49fc069'),
('includes/menu.inc', '3613d45c65662a5edd86e715ffdc9c411232690e11b6933ed06569cbac8c7e9a'),
('includes/module.inc', '943626f94bc69e95e36fde030475d57893f3296f0f8df461e2ee9f122dd37473'),
('includes/pager.inc', '7d8d827eb2baace7031a02fd4b15a5e684928cd8345f878dd707adce11f93bd2'),
('includes/password.inc', 'fd9a1c94fe5a0fa7c7049a2435c7280b1d666b2074595010e3c492dd15712775'),
('includes/path.inc', 'acfd48f5582893af86cbb5ccf331ddb43bbf2671e879e5424a21c928d06d949f'),
('includes/registry.inc', '2067cc87973e7af23428d3f41b8f8739d80092bc3c9e20b5a8858e481d03f22c'),
('includes/request-sanitizer.inc', '770e8ece7b53d13e2b5ef99da02adb9a3d18071c6cd29eb01af30927cf749a73'),
('includes/session.inc', '68dad2eb48e0f7336c7dfc953b4b8b23c95042de9ad480d127beeefd46552250'),
('includes/stream_wrappers.inc', 'b8a5a53f3d3ef26ea868037547f76af8049ce0c55b464810c627310a84f24924'),
('includes/tablesort.inc', '2d88768a544829595dd6cda2a5eb008bedb730f36bba6dfe005d9ddd999d5c0f'),
('includes/theme.inc', 'ffef4dc87e40ba6e57ac90fd1d81c30ff59da9f5407ddbae98d5597cbae5691a'),
('includes/theme.maintenance.inc', '39f068b3eee4d10a90d6aa3c86db587b6d25844c2919d418d34d133cfe330f5a'),
('includes/token.inc', '5e7898cd78689e2c291ed3cd8f41c032075656896f1db57e49217aac19ae0428'),
('includes/unicode.entities.inc', '2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54'),
('includes/unicode.inc', 'e18772dafe0f80eb139fcfc582fef1704ba9f730647057d4f4841d6a6e4066ca'),
('includes/update.inc', '25c30f1e61ef9c91a7bdeb37791c2215d9dc2ae07dba124722d783ca31bb01e7'),
('includes/updater.inc', 'd2da0e74ed86e93c209f16069f3d32e1a134ceb6c06a0044f78e841a1b54e380'),
('includes/utility.inc', '3458fd2b55ab004dd0cc529b8e58af12916e8bd36653b072bdd820b26b907ed5'),
('includes/xmlrpc.inc', 'ea24176ec445c440ba0c825fc7b04a31b440288df8ef02081560dc418e34e659'),
('includes/xmlrpcs.inc', '925c4d5bf429ad9650f059a8862a100bd394dce887933f5b3e7e32309a51fd8e'),
('modules/block/block.test', '40d9de00589211770a85c47d38c8ad61c598ec65d9332128a882eb8750e65a16'),
('modules/color/color.test', '610ba154f42b6af5871fb09cdb0bc7badc29b03845c08d86e0e524840dd27568'),
('modules/comment/comment.module', 'db858137ff6ce06d87cb3b8f5275bed90c33a6d9aa7d46e7a74524cc2f052309'),
('modules/comment/comment.test', '9c05ad98e4c2e1b00c95c6a3ef71d97c5aaa87f1bc5f9c3ae5d3378b05b16c2f'),
('modules/contextual/contextual.test', '023dafa199bd325ecc55a17b2a3db46ac0a31e23059f701f789f3bc42427ba0b'),
('modules/dblog/dblog.test', '79ba7991c3f40f9241e9a03ffa43faf945c82658ca9b52ec62bd13bd80f41269'),
('modules/field/field.attach.inc', '2df4687b5ec078c4893dc1fea514f67524fd5293de717b9e05caf977e5ae2327'),
('modules/field/field.info.class.inc', 'cf18178e119d43897d3abd882ba3acc0cf59d1ad747663437c57b1ec4d0a4322'),
('modules/field/field.module', '48b5b83f214a8d19e446f46c5d7a1cd35faa656ccb7b540f9f02462a440cacdd'),
('modules/field/modules/field_sql_storage/field_sql_storage.test', 'f156a1147808a486b98a52ab7f3535292ce1b903f0a4ee998b88aacedd3c7ccf'),
('modules/field/modules/list/tests/list.test', 'c1a214d7efd3247dd947d742a8514ec9649da62593608dfdccee6913d48e5709'),
('modules/field/modules/number/number.test', '4392f6fadf67c7533725e12bbe15ee2624cd54158e153f42f6cad3c28144395e'),
('modules/field/modules/options/options.test', '1b30956b6f46840ccb41b99bda08f328172f008f1fb4164c65fe9e4047fffa5f'),
('modules/field/modules/text/text.test', '5c28b9da26417d2ed8a169850989c0b59f2b188a0161eb58e2b87c67994d602d'),
('modules/field/tests/field.test', '5eaad7a933ef8ea05b958056492ce17858cd542111f0fe81dd1a5949ad8f966e'),
('modules/field_ui/field_ui.test', 'f535e5627c969e9083a63aaf72d4ac645e30709d7b87af15c6c3b870481f283a'),
('modules/file/tests/file.test', 'c5f7592b47329f7a3ab44f9c218eebcef639760cd78180b566551c53bcfe9473'),
('modules/filter/filter.test', 'b8aa5e6b832422c6ad5fe963898ec9526c814614f27ecccb67107ce194997d6a'),
('modules/help/help.test', 'bc934de8c71bd9874a05ccb5e8f927f4c227b3b2397d739e8504c8fd6ae5a83c'),
('modules/image/image.test', '6e7a0cbcb58f6210127b0ac7c1d118d488abd0925fe8db10a3405af87f1d9fe1'),
('modules/menu/menu.test', '71efd7117a882fdcdd50971b4a68f7f2895b532e09acf094d747f27a15742c5b'),
('modules/node/node.module', '45a35bda7eea00f6636c85cef8aea3ced2a181ff6d6841f71603e286607f12a5'),
('modules/node/node.test', '35bf40fde62f3a1de95bab9f037b84f20c2f93a1c579d7d19e4a87afe75dc330'),
('modules/path/path.test', 'f7d3b15f94773f189c0a64c364c9dd0e17c0ef75d801ea1ef9c76f75328b92a8'),
('modules/rdf/rdf.test', '9849d2b717119aa6b5f1496929e7ac7c9c0a6e98486b66f3876bda0a8c165525'),
('modules/search/search.extender.inc', '1a92d28913cd9d7cd0d2ec007848e079c14e84a8bcb9423e70ad97309ac14eb6'),
('modules/search/search.test', 'e43c21510d510885dfad6484afa931382083b75b7e67286bda56a6aafe265f28'),
('modules/shortcut/shortcut.test', '0d78280d4d0a05aa772218e45911552e39611ca9c258b9dd436307914ac3f254'),
('modules/system/system.archiver.inc', '05caceec7b3baecfebd053959c513f134a5ae4070749339495274a81bebb904a'),
('modules/system/system.mail.inc', 'd2f4fca46269981db5edb6316176b7b8161de59d4c24c514b63fe3c536ebb4d6'),
('modules/system/system.queue.inc', 'a77a5913d84368092805ac551ca63737c1d829455504fcccb95baa2932f28009'),
('modules/system/system.tar.inc', 'aa4a44368064cfa08034bf35438c86282492d09fbd6a4bf02fa5da3d66c7c52e'),
('modules/system/system.test', '6315d4c3306d99f6143a3b59b6556d15d4b60dfc28239a91ee1b0c0c48828704'),
('modules/system/system.updater.inc', '9433fa8d39500b8c59ab05f41c0aac83b2586a43be4aa949821380e36c4d3c48'),
('modules/taxonomy/taxonomy.module', '010e2eba7166174b1d188330e8368c6022d3f790c46d9ae79f63f69b5f8d1df8'),
('modules/taxonomy/taxonomy.test', 'ce91ff8a2879d65fdb3477d3f437cad8ef50b8963dadb75ae203854987b2c23a'),
('modules/update/update.test', '994b66b737f16eb98ee18c9e9ecd62e86de2792159e70b36982e95b48f2746a3'),
('modules/user/user.module', '615a2e5a894a9aa4c206834f3e1592ea21b2be7399906504f14c6eaf801200eb'),
('modules/user/user.test', 'f6546eef5f9e272abd7f1287d9013441dd65c45b7045f87381884c7509285b76'),
('sites/all/modules/contrib/ctools/includes/context.inc', '2057a0331cf54e23ef39aa84b7c60f486aff749223367a30f3513b05dde35f3d'),
('sites/all/modules/contrib/ctools/includes/css-cache.inc', 'db90ff67669d9fa445e91074ac67fb97cdb191a19e68d42744f0fd4158649cfa'),
('sites/all/modules/contrib/ctools/includes/math-expr.inc', '0573737d85980dedf76cc9c82fbc2654ed07fce8ff7a8da4be2e2cd7de67b99f'),
('sites/all/modules/contrib/ctools/includes/stylizer.inc', 'a19b912a79e6d982a6bfbb660c108a047e41283a23e1b12e4b9c22af51771add'),
('sites/all/modules/contrib/ctools/plugins/export_ui/ctools_export_ui.class.php', '33ca784ee967dee1234372e6075505ce57f7685b494e4fa477318579bb85ccbf'),
('sites/all/modules/contrib/ctools/tests/context.test', 'bc23a86c5c32a0335c970f1e51ad6d60cc02d006de3d5cb5ee0bbdaa84d5bcd3'),
('sites/all/modules/contrib/ctools/tests/css.test', '832c58634157083e988797bf878c5fd6b9640e187802a397763e25771eced028'),
('sites/all/modules/contrib/ctools/tests/css_cache.test', '331564b96148bb666b306ead748b8b18a7baf746e96d6564b9685a23ca47a888'),
('sites/all/modules/contrib/ctools/tests/ctools.plugins.test', '2dbabab681d5a9e15e093aef5a48732dcdb030680b932c7a0c7260e444751919'),
('sites/all/modules/contrib/ctools/tests/ctools.test', '427659c5c3db1e8638539b6dd1a440451e043129172a42f66f3f9bbd15e8db0b'),
('sites/all/modules/contrib/ctools/tests/math_expression.test', '0fa0cd1f54c9a3791a5d77220bfee16baa868d0911f0c834b9682346ba8c0df6'),
('sites/all/modules/contrib/ctools/tests/math_expression_stack.test', '203b98c797d7eaa787c6481c1ab9482c0ca45559314f79632d7c5efb51d7d170'),
('sites/all/modules/contrib/ctools/tests/object_cache.test', '0af88e1d17b8265ac621799922934dded7c44073c001acf8c1c47d0187cb52fa'),
('sites/all/modules/contrib/ctools/tests/object_cache_unit.test', '9fd7871c5f0307247469bcdd488f3086126f5f7978d6a470f8ecb8a6dc4b5a1e'),
('sites/all/modules/contrib/ctools/tests/page_tokens.test', '078f82bd0957d8821521388fa270e70e10e9f143c1012ebac60f2dfd4d9ab1a4'),
('sites/all/modules/contrib/devel/devel.mail.inc', 'f335a5ddf13e6ab9c11c43ff8856fd1964fdc6fe13ad81348c03f6850fba1ac8'),
('sites/all/modules/contrib/devel/devel.test', '689418eff02edb09cd264254dcc5f3339f187eca655519c8cdf0a82994f82280'),
('sites/all/modules/contrib/features/tests/features.test', '07dd3267aaf3c8c043052875a59e7ca6359937dcb21262f52ff6ccca072230f8'),
('sites/all/modules/contrib/views/handlers/views_handler_area.inc', '16085f6aff78a35dfb536909e82e0ebba99f382d4abfeea74f86dfbbe576938b'),
('sites/all/modules/contrib/views/handlers/views_handler_area_messages.inc', 'a99ce6f396662fd511f0a5b4dd44289940c61eb19419fce952e8cd1d92fb540a'),
('sites/all/modules/contrib/views/handlers/views_handler_area_result.inc', '614026de7b8f6fd6aee56396938ba6354ef3dc7908a93159051389ffafedebb4'),
('sites/all/modules/contrib/views/handlers/views_handler_area_text.inc', '9b249c72a27c425e554ac5fc4f5bfe5030468e941197a5f2a728251e1a1709ba'),
('sites/all/modules/contrib/views/handlers/views_handler_area_text_custom.inc', 'b834a5b12dcb0437734337d50d81af185e7e0149fbad853addec5d2c6992c8fd'),
('sites/all/modules/contrib/views/handlers/views_handler_area_view.inc', '62faaa2aa80df6c136814acde663a7055a5c17bc6e2975ff566464a8fb90a38e'),
('sites/all/modules/contrib/views/handlers/views_handler_argument.inc', '55a60cee0a22b2b3dc8b1bcd556ee329d7e01c53e9b009866dd24eac0f552a3e'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_date.inc', 'a74a274dd15c9453b227c5fa78005ec64551d1d608c349f8cdfbb3966179797e'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_formula.inc', '2090ca11e6328bb3b5c149a18027519bbfcbfdffed66d4c8c1e69316593199b3'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_group_by_numeric.inc', 'aa65e69556046558f52929009b129ea74ad4f4dd3c79dc517317082be298cad6'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_many_to_one.inc', 'e3b119709ebdae549a45a33751413d591fd29b886091257cb9f76afc87153612'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_null.inc', '9c26fd85eccdb9fa5483ea9b556b61bfdab0c7e802ab8516f04fb54ce6e3c501'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_numeric.inc', '366aa47d02f8c1f69cb9303bf56283601c07c7272a84ad4e6fe35b1bad49c8f3'),
('sites/all/modules/contrib/views/handlers/views_handler_argument_string.inc', 'b9eb2bc894cd92ab51fe2e09f12b08965561c890df93029877ea520791a51e8b'),
('sites/all/modules/contrib/views/handlers/views_handler_field.inc', '08c7f960f15d98ffdd1649f66c1439105da77b8850d8ca16705a07898932490a'),
('sites/all/modules/contrib/views/handlers/views_handler_field_boolean.inc', 'c4b6fe66a0af7f21db4597f5f697c8a2d5ed5ea413471bb34c31a776b1250e6a'),
('sites/all/modules/contrib/views/handlers/views_handler_field_contextual_links.inc', '58adabc6212039a33d232130a07622ba281385ceb8e3b33ad688cd4aefc6754e'),
('sites/all/modules/contrib/views/handlers/views_handler_field_counter.inc', '701ade124c2e6c08a459ef5445ceffd3dc16348c752db8eba86d9182ebc93658'),
('sites/all/modules/contrib/views/handlers/views_handler_field_ctools_dropdown.inc', '77e35b9f6e95f16c41de1d7a1abc608e48b77aee36ca05874d3b69046e04e5a4'),
('sites/all/modules/contrib/views/handlers/views_handler_field_custom.inc', 'd3c2b1df06ec7f74f52e1188c9cd26eef23b09928f2d0355bddb2d14a985d221'),
('sites/all/modules/contrib/views/handlers/views_handler_field_date.inc', 'ac3229b68a791fe43be920a02944a67b3fd0747f81c7b50e3ba824f3825aca0d'),
('sites/all/modules/contrib/views/handlers/views_handler_field_entity.inc', '3ffdaf1c310f36ea61e7c1766acc112c6683a9a7bb99a5baf48e3ca121322eb3'),
('sites/all/modules/contrib/views/handlers/views_handler_field_links.inc', '8d1d612ccf6e0ad5c18086bb32ce9727dbf6ccd0520384cb6265cec42e9772c7'),
('sites/all/modules/contrib/views/handlers/views_handler_field_machine_name.inc', 'edbe2e4a2911d4ecdbf1c58f6645dfddf28f4434be809ba64e01fe9ea94783d5'),
('sites/all/modules/contrib/views/handlers/views_handler_field_markup.inc', '94a925ba9dcc866929cbb30b895ae75aacae60688ac0e38a1a84cc90ebbd51e6'),
('sites/all/modules/contrib/views/handlers/views_handler_field_math.inc', '5c9087cb87791ef94dd1830da08585efba43b28a09f9227e36a9c6e764ddc8f4'),
('sites/all/modules/contrib/views/handlers/views_handler_field_numeric.inc', '4fefb5c808f0a7cebacd4b2cbaf25b165a93d3bb4b35b3628302bea6b9031614'),
('sites/all/modules/contrib/views/handlers/views_handler_field_prerender_list.inc', '4332691d10f6d0ed91f3b4279499f12737314555fdd6c87a3556d998528545c9'),
('sites/all/modules/contrib/views/handlers/views_handler_field_serialized.inc', '14997b7d224d5dd50295f71cf626bd4e4eed0d906d6da32b92037cc734ccac1e'),
('sites/all/modules/contrib/views/handlers/views_handler_field_time_interval.inc', '4b6f36465710740d6e266f1cb731b3c0c72ba7455ee0fecee80a847131b3e7de'),
('sites/all/modules/contrib/views/handlers/views_handler_field_url.inc', '6633a403da44af6e82188fe1416bd06a6cb1f69e0546f162296d2c2e79af255b'),
('sites/all/modules/contrib/views/handlers/views_handler_filter.inc', 'fc530fa4eb2458f0b5dfed71d38aa4f13761b4706955c0b1d859b9409cea8ea5'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator.inc', 'e9089bb8135313d5650c6095d91fb0682f0a0509108b567ccb13f352bab14db0'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator_string.inc', 'fd2bd503b46361ada4e6b4ada3451b322f646c68de5591e13b194c733ad683f4'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_combine.inc', '6dfd069622016d0239cfa85311660c1f17173243c381bdca1ef84410c67485af'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_date.inc', '29d7bbbef9564122a7a83281699fa084596d326c76ac477a691f50fae48fdcc1'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_entity_bundle.inc', 'c7e82ca67ac0e66740ce247829179158462dc4bf1d119407009460db1cca973e'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_equality.inc', '8188497af26a099cdb0d7ca3feda14ce288eebe1d02f87348f30da1ef99993e2'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_fields_compare.inc', '9639036d337eed13379a55ecbac33d1b059c2f38ce20ade614d6819cd0e29a26'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_group_by_numeric.inc', '1258029768dbdcfcb5cfffcac09b22789fe36e91618a4a06e1e4a4b6c6c19d41'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_in_operator.inc', 'd54e35c8800930b149a2e2796f0990c079be0ea8359b03bc290ecffc096b14ed'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_many_to_one.inc', 'e8cb18060c952bf11148c2247ec14201fd499ac005c092e7d96734d83ac9895a'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_numeric.inc', 'cdb51e786a1e32ed91d84f96085f72cf2b846afbf6d6e2860658604be294bbc5'),
('sites/all/modules/contrib/views/handlers/views_handler_filter_string.inc', 'cf1da75621747176d5a582634205172fd718ea57548220b9aefc9aa9892c7944'),
('sites/all/modules/contrib/views/handlers/views_handler_relationship.inc', '56f8b9a3085aee56ffedc75f76a9334c57796f2cd3fe9706506683f46b85a0e4'),
('sites/all/modules/contrib/views/handlers/views_handler_relationship_groupwise_max.inc', 'cee644bef90c8d4412c01a16f8189b6a5e912d36fcaf181c2cc1198012fd7bbb'),
('sites/all/modules/contrib/views/handlers/views_handler_sort.inc', '36391f1498cce13b2f37343da53e61ec437f6f1afd0fa3f1cc4c0627ca42e2d3'),
('sites/all/modules/contrib/views/handlers/views_handler_sort_date.inc', '9949279b1d2f714afa51fba865749a40546ef434f9ba5e68bf8fe09ed056fed4'),
('sites/all/modules/contrib/views/handlers/views_handler_sort_group_by_numeric.inc', 'ed4196d099a2c5112b46ce1cd256edf71793e130a5ed49631fff2a365fc3291b'),
('sites/all/modules/contrib/views/handlers/views_handler_sort_menu_hierarchy.inc', '60628a647e83f991b2fb42506b1c52fc8934cb19278fefb2ffe980065d027136'),
('sites/all/modules/contrib/views/handlers/views_handler_sort_random.inc', '672a9473a35bc811d8bb0365dedfff988671de9c00e0e703819e9adaa70db4ba'),
('sites/all/modules/contrib/views/includes/base.inc', '1eb8aea63c9d50a9a13af71ed49ac76951bd65713c4aba9adc6ce43e402a97e6'),
('sites/all/modules/contrib/views/includes/handlers.inc', 'e4de191788ceb6c51f4005b3abcb1c22acf2f5c70b18778d3f8832d6e1b65e8e'),
('sites/all/modules/contrib/views/includes/plugins.inc', 'b41a59b67e719abc1df93d022a37c0cf701059d1cf566fab6edee6147bdf0369'),
('sites/all/modules/contrib/views/includes/view.inc', 'f862b14fdb3e5eb913f389c6f289b60678d6e35fe4c29a41990ef5df6ee1cefd'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_category_cid.inc', 'e67a696600c3c9a37f8c732b89813500f207eaad32766f2e804c02063cdfb17c'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_fid.inc', '51a2520546cac7d4c56a80f2b61dd41a878a4a75037f0739e214ff8155a0fef1'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_iid.inc', 'c3045fdf47ae7639275090768d7d9a2358cd66e9de600e2cfc7ae52b5cd64c05'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_category.inc', '9af125c4285d770572757e8ad114048e4243dd6710bcd992c3b8365aaf3d5cbb'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_title_link.inc', '717fe70dc6f4a00a808d3ea478fd146c108be26e0c5773f4574b073bce0ef3b3'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_xss.inc', '83ba99ebdc04ed18e266a41ed97c874c81002f13059815e353976668d68e6de3'),
('sites/all/modules/contrib/views/modules/aggregator/views_handler_filter_aggregator_category_cid.inc', '3d819f5de170c4d4f2e8d3348be5645f27059854169725375fbc5e4148e772e3'),
('sites/all/modules/contrib/views/modules/aggregator/views_plugin_row_aggregator_rss.inc', 'e73716935ee6172dc5c6dbc6126c00decef6759da8cb05b278089328661583c1'),
('sites/all/modules/contrib/views/modules/book/views_plugin_argument_default_book_root.inc', '123eda93e4ad9da88a6dc3ffd771772ea71abdf1d749c8f2d17c48d656fb0d5f'),
('sites/all/modules/contrib/views/modules/comment/views_handler_argument_comment_user_uid.inc', '9955ba779f626be3dbc18a5d5c3b7e0d4638ea32ce606fbc9144044965b491a8'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment.inc', 'beb5e6eb481aa5adbc347ed7ef31572fcd63a892aa83266b9000f9569508f7ee'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_depth.inc', 'd316270160be29bac6e50d990c34d51811f9520359458331fced5ea6535a920f'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link.inc', '77f3fdaef1bb183bc6f51f9bcdcff7f5c267f02d731c6e774d7964048674f635'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_approve.inc', '3a1587ed47b306e0ff6dd0298e7a1cc0a899c91b814dc48239f7173027fb692f'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_delete.inc', '03ca804e176402c955734151de2d8ec1f77a558efbeabdfc0a2550026805a986'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_edit.inc', '4ea1157e43d2c04d15250aa2247223a5ebdb3cde5cd751ee8d9976ce09701fd5'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_reply.inc', 'c65548a886717de8cd8de65653866daad70395e396a77f67f0ba788eed29c1cf'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_node_link.inc', 'fc093dd213dd5a9b66830b51083e8c94af1a4cf66485d242199284b20e84bf84'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_username.inc', 'dce17ff9703a545bb55f10aa51e702ab318ba6652a308bd4bbf7ab509816fbee'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_last_comment_timestamp.inc', '3865475732389244162027b2a1dd5c847b97f8007bd08bb597ede0a2abc07a33'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_comment_name.inc', '227bf7ff4ba7464310b75196da3f85e3eb9a8da89f667b6153d5023d93034105'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_updated.inc', '3a75c18196f060e268ed4a764039f63cfde4d45d157673b19171a6eed5fa1c79'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_node_comment.inc', 'a3e9f9cd9e251e866ec1fc6e6072fe90e83ff4b882a6aa2796ec8721129dc2cd'),
('sites/all/modules/contrib/views/modules/comment/views_handler_field_node_new_comments.inc', '089a6649c4039ec3a855798fa131c01a5c8930928e47493f3c3073fb9ffc040d'),
('sites/all/modules/contrib/views/modules/comment/views_handler_filter_comment_user_uid.inc', 'fedb023952d2b1b418848293f45f4f33adf9c885d279655ac0f6761d2dca11d5'),
('sites/all/modules/contrib/views/modules/comment/views_handler_filter_ncs_last_updated.inc', '40f9157a53807537a7bd8d5989e6abafbbc3b9b296958207e97944165f9ef639'),
('sites/all/modules/contrib/views/modules/comment/views_handler_filter_node_comment.inc', '222e790fae64c087c755949bdd98b2f70851c20c22ba7a0a6eebeca1ccbff8ed'),
('sites/all/modules/contrib/views/modules/comment/views_handler_sort_comment_thread.inc', '91fb14f3058c409bef347a0a76c48fe9f4715fcfa49b35a19899e74dfb4e3358'),
('sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_comment_name.inc', '1b988db986ba10fc1052297d6bf47ffed64272032a6aedadb742a7737a8a04bd'),
('sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_updated.inc', 'd7ce11c55dbeef236965d2708cf4ff3f6fd751835b0e63538031600c8dd6b48f'),
('sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_rss.inc', '661a484de92222f270d2894ad9b5372165e4a8beee815aa52628e656757f331e'),
('sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_view.inc', '33a763b97f3b8998011e01e967e1a92d988215af365b8db0ebd4bdbc9a081870'),
('sites/all/modules/contrib/views/modules/contact/views_handler_field_contact_link.inc', '94aae2c3ca97edaae19cf8291b9255a9f50e28507307ec3d6ee3b84729ece1ba'),
('sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list.inc', 'c2782930964ee2e312ca238357b7ee3e0769372cc1216c604b2633677729c58e'),
('sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list_string.inc', '1e3d03b1338c2ea5c7550e0ae4966dcb8e163ce2b3538d8654c0c4d3620f0898'),
('sites/all/modules/contrib/views/modules/field/views_handler_field_field.inc', 'ddd9b0e1e1f452218798b1d2e808d084528d90ab80a3f6b3d9db54513f36d612'),
('sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list.inc', '77fcfe98e5fb1638c879a3fb2dc6769e49a79cf348e26e843566175b01358730'),
('sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list_boolean.inc', '028a78d1bdb1b5495dbb1b484220a9d8e31ca7b69f20f119a35fb6d58c7a0160'),
('sites/all/modules/contrib/views/modules/field/views_handler_relationship_entity_reverse.inc', 'b14ede644a0f64ad2eab73d8c09dca5859412fedbd97ee0580d1d6fcdecdc819'),
('sites/all/modules/contrib/views/modules/filter/views_handler_field_filter_format_name.inc', '2a0a6d07ec0352260fc3e94c6f08e15afb0888dcc05d4184ba49de01be8b9fea'),
('sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_group.inc', '754ebf9a38ae05593fe74be7e4f0a887c12ed710da340c3066686f3f5740c256'),
('sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_language.inc', 'ee06594ed7558b4e7369d5d560f3c9f1b8db4442e410e81bb282b45c4b5238ba'),
('sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_group.inc', 'fc6a3c57d9abffbe1cfb859c6adfdfed5f2c63cb645df1ec732f84ee2e8f4f4c'),
('sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_language.inc', '431fc20daaf9cccd4d739b16a6cb9a732417b5b6079b12cbb73710fee2a51e9d'),
('sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_link_edit.inc', '63dc823990a69622585a21212f2e162e2ce018a9c1348c148a3e5215d005e023'),
('sites/all/modules/contrib/views/modules/locale/views_handler_field_node_language.inc', '76e09d9b0f4c345425a52f9def5aae5e029e6ac9dd079a242dfa9aa98f6cf010'),
('sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_group.inc', '2c9da2c417de6cb48a13b4bb52dd9d9ec0a4f257ee4e26b7b99ca46b10334ceb'),
('sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_language.inc', '59749963fd5fbebff0a6e09b5553b0ae639bf2f053da7aab325d0662093f3b04'),
('sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_version.inc', '266f380b0488af0ebaec0c9b0f8168402bdc53dfdd29f6a81924c88c04829287'),
('sites/all/modules/contrib/views/modules/locale/views_handler_filter_node_language.inc', '70dd129038f85a61f1a4bb24ce4286520154546f5696a135de8f0f2caf39ac15'),
('sites/all/modules/contrib/views/modules/locale/views_handler_sort_node_language.inc', '7f24790cf76cf979e9314d12a269b39f2b10d2787b69dc8a3a9b51d0b3ed4ae8'),
('sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc', '6308402609dbc7f92594e4e5d4f4f0cb5ba71e43c6f247cb71af111c53db83d6'),
('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_language.inc', '85d5ec6d2cb7fe84ba59d27054f170207ee1b765366de7324d2f8b58feaae710'),
('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_nid.inc', '1c3517c618dc4704d48702250075384b9bf3fac50d24d5eed832a17f5dfa2da3'),
('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_type.inc', 'a79d743f7e0300feed39d7e9f1cb46bfe470c4639abc47f0110190d413e1dbc0'),
('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_uid_revision.inc', '04e049eb41769c91b3bbff1be5971bdba0b56d4c9e81f7b564c2ec0cc8c8227f'),
('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_vid.inc', '2bb53e69fcf14294053c5610fe40408f6adb5b25bf6f0c6d66c0848cb90615bb'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_history_user_timestamp.inc', 'c9bae50db9659597b7e8c1533ac2606919517811ace4b7dc786b7f48a264020d'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node.inc', 'e13196a84647ec0bd6a4dcb92cf5d6e340bab0e9aeadabe723567e8c7abf21af'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_link.inc', '450c511b8fada8689fbecd1f92fd208c4add47699e97438bffdd682415e1fe00'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_delete.inc', 'ab50268cfb67a3deafa21a7f5acb5c908d378efe6dbfd6e1537cde1487fb0a09'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_edit.inc', '91aebee3065d3880773b81d8d3f1d062804162454265f8be12bea3681d0791b0'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_path.inc', 'fe9bd2b94c7ac927c78aa559783e12bea69abf2f9bc1ad8bbd250826bb295597'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision.inc', 'd3c7c25c86da0615304764c09e76b2d3f94da06975add14e539964a53d0afab8'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link.inc', 'ea7b46f10f54fd565bdc6b6a78c581de9889b20afa1d2773bbb51f9dc9ce4da5'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_delete.inc', '329a3063a79278c72fbc7a3dd87d9a309a62f4dac039785ff3ac43000b48155f'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_revert.inc', '939815ed25649dc4646e26042868cc3eeabf618ba750e84900c74017d181a675'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_type.inc', '0296f415723508d2c68d314394055d5ab14df0958bc6cb0158eba2c395494f07'),
('sites/all/modules/contrib/views/modules/node/views_handler_field_node_version_count.inc', '42ed9bbe09e407f5452e8e8523cb8719c46a41d6a60eca449b0182e7dc9e9298'),
('sites/all/modules/contrib/views/modules/node/views_handler_filter_history_user_timestamp.inc', '83028bbcc531cd39d5368e4b2ec68c5569fb1d12f35712bf14c7cb3da4aa7e91'),
('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_access.inc', '3f6a4da11b627de054c2e14b4869a521352d501d1be18a05f1c67db6ae73d18b'),
('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_status.inc', 'bc823f0c6771f62bb67e1ff79aa4542ebf9bfcee6f5b97d65a7a3b6d2df1ade3'),
('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_type.inc', 'a49a3da3983e79c4aa9ff237f1db5fd808117e939d7c619d62b63f95ad333582'),
('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_uid_revision.inc', '40c2c6b4437e1446cfa41ac45fe29ebeeaa2a37796582c068dc37c6c35a1c88c'),
('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_version_count.inc', '62d2b9095bced391c270d5293d239dba135955dc9157db747d01dca64c45bc56'),
('sites/all/modules/contrib/views/modules/node/views_handler_sort_node_version_count.inc', 'b3b3012e04c2d90f7ae810f41748eea58062f291794a840d5ca951dadf22906b'),
('sites/all/modules/contrib/views/modules/node/views_plugin_argument_default_node.inc', 'acd3fd318bcfcee6eac4381b260a539d6d79c63bc0f350932565b0dbe7e05961'),
('sites/all/modules/contrib/views/modules/node/views_plugin_argument_validate_node.inc', '2c8100dcf21a8d1f24a5e8621f9bbc6d7bfdd3c41b7a191d904f8c854df6d02b'),
('sites/all/modules/contrib/views/modules/node/views_plugin_row_node_rss.inc', 'e9f5f676c0be810ccd6aca1f3c28f8ddcbf8af4b19a9bf6b049e6056b15461bc'),
('sites/all/modules/contrib/views/modules/node/views_plugin_row_node_view.inc', '2b64a6646cb8cfcbc0448133802d6d5effae2afc53d312ed783a87d2125f890e'),
('sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_date.inc', 'f1f23952836ebc20b7507250adc6ad0544e070a5b9e373afe3825b68c5caacb7'),
('sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_list.inc', 'f938abe03f7889fe51db5904c7ca40d0675cf3f6d452684dde3eacaef5aa6db6'),
('sites/all/modules/contrib/views/modules/profile/views_handler_filter_profile_selection.inc', 'ca90aa667fcf313dd5676556b8fda60c587063cab3e9a42695199886f978239c'),
('sites/all/modules/contrib/views/modules/search/views_handler_argument_search.inc', '8bca051703deede7e59cc3da73c68dcc77952899f76c3308e4853111f744ae5c'),
('sites/all/modules/contrib/views/modules/search/views_handler_field_search_score.inc', 'b70e66940c7ddf22a9f51475edb99124faf3a1a9fe94cc9131ad5118e49b80f3'),
('sites/all/modules/contrib/views/modules/search/views_handler_filter_search.inc', '940712aa47b2eb502a7bc8b255250bb7e915e8f89875798f4a0d41013b131e3f'),
('sites/all/modules/contrib/views/modules/search/views_handler_sort_search_score.inc', 'a9736feee51cb2f54bc5af8a4120aa6027bf6b44d394dc4ac308999f138fe842'),
('sites/all/modules/contrib/views/modules/search/views_plugin_row_search_view.inc', 'c8d6a5b3f0b2c795b6e7efe9de0c7598ff709aec09455de22b3b26bc366c65a6'),
('sites/all/modules/contrib/views/modules/statistics/views_handler_field_accesslog_path.inc', 'e514b0ac78bbce36f6fa94bc3d7f39e3506de9bf8f5ffc149efd341f940b246c'),
('sites/all/modules/contrib/views/modules/statistics/views_handler_field_node_counter_timestamp.inc', '9493e13b361038b41959974e8c9eb9dec7970024d1dc8754c8a5f1044567d7f2'),
('sites/all/modules/contrib/views/modules/statistics/views_handler_field_statistics_numeric.inc', 'e29fc2f1fe0e5e87cc594ec21dd81a778b7eac3e99518aad1820a3cb0c68aa86'),
('sites/all/modules/contrib/views/modules/system/views_handler_argument_file_fid.inc', '2e836d50b8a5fffa2e30cb35a2361aae8aef2f2138e90d12f9de20d74c77b622'),
('sites/all/modules/contrib/views/modules/system/views_handler_field_file.inc', 'b8a83503931abf9d0804b865f28cc9725520afaefde2a36ee8369670098013b3'),
('sites/all/modules/contrib/views/modules/system/views_handler_field_file_extension.inc', '83f2f4de5bcad4c04c9f338c6afb1cd321f1325cd6908b65bf246626b62cacf4'),
('sites/all/modules/contrib/views/modules/system/views_handler_field_file_filemime.inc', '8a83f83bd135c71fe2b763f31aaebe6df392a46eee88e8251c15a1be7a96c1da'),
('sites/all/modules/contrib/views/modules/system/views_handler_field_file_status.inc', 'e61cefaeb45471b0d95d756ac9bba45fe8dca0fb10ac9bd82fd9a32385175118'),
('sites/all/modules/contrib/views/modules/system/views_handler_field_file_uri.inc', '8edae85b8a83b5439962e73cae1cf1834b77d9c4a157035e2c1b3b265a9e75a4'),
('sites/all/modules/contrib/views/modules/system/views_handler_filter_file_status.inc', '630e79a1e4186e955fea776b0d6ce4316d30daf0c1b9594a654cd875f8139e17'),
('sites/all/modules/contrib/views/modules/system/views_handler_filter_system_type.inc', '024f4708e1ad9e626c56dd288590d39ac2b4be316cf265099a9fe7ad0169a97c'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_taxonomy.inc', '64d79041c19de4a04675db80cbdeb195bd4b7348f05eadc658fec9103d452d47'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid.inc', 'fe5278a0ca737d4f207fa956f2adf8f875936903af0965f61d1b436ca4546fb4'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth.inc', '46f0b0c72c912b854e10686297d52183e186e4da16301c047ab2b9966950e2fa'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc', 'bd8af035a5e1849c9bccf519c82df814b5e0905441222559a4db2c685a962099'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc', 'a4ae0d39e66a051c3ee6b5e490887c3a12679854e98b620e061bd6e06849db01'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc', '53bd1e4831645069b13f9a9646ae9b74c09e07b997ce10a552c32138d685969d'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_vid.inc', '5187c6e68cbc69b6f9a01513f3a8de5384a9b8795bf68415decdcc08995caf3c'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_taxonomy.inc', '8c57d2bd1f41bcaddb5eefe70dfd6ec98b3f22cf8f37d860f7f6e67c3592f1dc'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_link_edit.inc', '5aa6148b1866311d455897c6c62a773b98fa9988a94187eb0e9fb43c76925cc0'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_node_tid.inc', '82608d9d6109d1446f70caf5ad176cbdfcef283a1e5fa2d5565c0572f3a9613d'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid.inc', 'bc4d5a8b9cc3215a2283ea6725ebfbe0cda867b694491d02235abdc621179e57'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth.inc', '1fc479f4666696940f59cf330cfe22298d77e6587d16b281948ad05a2b1840f1'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc', '52821fd9d53a62ba65e24cb050edc3a7da78a7192e17e2202a8ce996a715dba0'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc', 'b8851e7c67a22e8c472417a97a528db0085b9cff614ac43edaf720378d643c8e'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_vid.inc', 'f15850128ed9a2c4b7b5964e31faf10570a0fa3670cd72afc09589cc0c432995'),
('sites/all/modules/contrib/views/modules/taxonomy/views_handler_relationship_node_term_data.inc', '9dff3dd77766232a4c83cfc92197424d4d2839052f7b91326dda39a81d484f34'),
('sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc', '3e6610928bbadd83e10f67ec4d508e2f3f848cc9d7a672c122038ccd3d73f315'),
('sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc', '3ef7a8d1ce5be4885c8d9b6df3fa578acecea6908bbca1f3baa80b511dab426d'),
('sites/all/modules/contrib/views/modules/tracker/views_handler_argument_tracker_comment_user_uid.inc', 'e2040743a77ba6ffad50b1601df62f6649747496f180a6e481f59cd320fd81ed'),
('sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_boolean_operator.inc', '0d0dca36d526ed1bd99f52dd91f113fb7fd3740778fb3ce2072bc39f90b9bb17'),
('sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_comment_user_uid.inc', 'a3cc9f7b3e6052973bea54dd354116eee5962a9b8e57636ee3f1c87577e85d51'),
('sites/all/modules/contrib/views/modules/translation/views_handler_argument_node_tnid.inc', 'd0493e7d7a6e182b77748ff44e71ed34999a20ac89830654c113e7c9a0d478f5'),
('sites/all/modules/contrib/views/modules/translation/views_handler_field_node_link_translate.inc', 'fc540176d6cc1d8e756a872f9e3285b607bf255f4b3ee0d9eb29d107df0dd401'),
('sites/all/modules/contrib/views/modules/translation/views_handler_field_node_translation_link.inc', '91caa7ac0bc4f465c9a5eb7e79ee63474d59e65ba9e2b6a9b5f466ab51d23031'),
('sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid.inc', '35509bc3b369b3f0fe541bdd86c4afdb32936d18dc52c32bac01b8f7bd3f78fa'),
('sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid_child.inc', '8b1282ee8b48c61782239982a7c3426033664d2c96c41896ef7decdba00a7655'),
('sites/all/modules/contrib/views/modules/translation/views_handler_relationship_translation.inc', '9d1ea9929aa0b5cf606732ca713bc6095902be0270ebe3e6a75620afc28be65a'),
('sites/all/modules/contrib/views/modules/user/views_handler_argument_users_roles_rid.inc', '31d6f0e24e88473a4790f9f97a80d0467a53ae1774583f71f7fce6c9edc1edf2'),
('sites/all/modules/contrib/views/modules/user/views_handler_argument_user_uid.inc', '6a4ca265f1585c08a7efb5667d0808683d6b1ecb831228b0928d0c7a1a946c41'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user.inc', '96b990f39f2ae5c99324b12b4f0d893c4c2b4b14b212261fdd5d0ddc0e95c409'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_language.inc', '156da9e421dd38f498f008c142e6dd515d5da67c44ff0ece4caff9c8f9b70f67'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_link.inc', 'd13886bf45cb49d2dee4823ff21106a10bdd0aa8ac0e387ca69f66729e203fe0'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_cancel.inc', '988c31b68a7e71dc4433ca4a72b692b0b9cfddd6d91ecec62435c882fbd88919'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_edit.inc', '0224a0f9268705e02e400125243540a5fb4ceda5fb12e700a6c9300df5f595cf'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_mail.inc', '90d20da35decf9afe27f3cf7665a0738ea972e9d3114114d274fb17054b59c97'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_name.inc', 'b791ae2231d2dbfcdeebf4dcdac2b130d101392b2a93d7e1e0ca42eceaa1fb76'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_permissions.inc', 'b0cbd86a6bd690f28b9b2d3c633d7f93153fac910be9dd25b248f7e628d4dfa7'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_picture.inc', 'd8b780012df737e968f83682fc6de9dfbe3a2b81ade2803d68626d77fdf84dab'),
('sites/all/modules/contrib/views/modules/user/views_handler_field_user_roles.inc', '248953e670fd9c6ee52486d218843e8c19b49f890df41396bf08d519c1392e16'),
('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_current.inc', '79b9f735c96e097366659876f85668547f788ca22a89edff9e1f8f84e0a4962a'),
('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_name.inc', 'bce96d7063b6f2f0b231ecf9b23f96c2e0b4fcde880238c2238306b5f4cb76dc'),
('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_permissions.inc', '9d8e37e0e78f128f8747e90f962a7bf993d76f750caa74b260d76c659394fc4a'),
('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_roles.inc', '742caf6b6e989b6a2fedf793d8e3d72e7e0444bf3f29b67c7f359fa333c870fd'),
('sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_current_user.inc', '30ba56c9372cbb73ad332146a795a13058239925e5660e8ef1a2a0a22cf34ba4'),
('sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_user.inc', 'e187ae191a4cbcceeef81ffe9bf3b4e32300da0763018bf168d274622ec5f168'),
('sites/all/modules/contrib/views/modules/user/views_plugin_argument_validate_user.inc', '38259ced6b64580ed263571e8dbaded1fa12a8ea61b7790ba5c9f8b2e29108b3'),
('sites/all/modules/contrib/views/modules/user/views_plugin_row_user_view.inc', '22c5ecc1886ef06a6faa6ebc22d8c6991af31b518dceb98eae54fcf18e8acc23'),
('sites/all/modules/contrib/views/plugins/export_ui/views_ui.class.php', '64f10c4d45ff3093eac94a227dbabfa54d6ac0d3269b8d42aee42bbff0024676'),
('sites/all/modules/contrib/views/plugins/views_plugin_access.inc', 'e1528e2faa60f47fd397fc6e272f88fcd1914c41bd942bb0a0f4a5073fbe1b6d'),
('sites/all/modules/contrib/views/plugins/views_plugin_access_none.inc', '52310ea867d6f21a11ced61fc1ba442836ca97c1e3020e1c5b5b5e9af3d29816'),
('sites/all/modules/contrib/views/plugins/views_plugin_access_perm.inc', 'f88fa2a6898e13bbcde8fe8a5786f3a2014b8b7ac830b6c848e6163d0454a5f1'),
('sites/all/modules/contrib/views/plugins/views_plugin_access_role.inc', '061fdcf1410bb0f785333a23e1293b369993ee6dcd95bfdaf686eb56335a91ed'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_default.inc', '04cb62069593b0d3de1e00b0eabd5e0b7aa4e8eeb0989713bb343edf229e5925'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_default_fixed.inc', 'e1f7aca5a279585aa6a4ff7e88fb896f25a6a91abab7cee2d8cf5b34f5b409b4'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_default_php.inc', 'ffcd3d49b72d8de2e73836d02ff00f9b0c6b9b4ddcf4a41cc32e35df3c426931'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_default_raw.inc', 'ed0f90f89a3618bacbf26377d499cc572c19eceb299bba4ed48fb2b97421321e'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_validate.inc', '9ae75fc5b1bf52f923c089ff03be6d0b13d3db1fec7c57d2d61765b57438ce28'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_numeric.inc', 'd895dec65ea4948641a3c58bdacd6482b37b1d1c6bdec3f35b6a0d2e42329277'),
('sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_php.inc', 'd3468db246b5f1274bd35e1926b515f06d3cd3ecfd54d26a914f3b28491a2c71'),
('sites/all/modules/contrib/views/plugins/views_plugin_cache.inc', '4ee5962d4dd833419da18a42383c0c444893c64508b08b5658104a70650a3bf5'),
('sites/all/modules/contrib/views/plugins/views_plugin_cache_none.inc', '5ce14a8ca7887019cacded3bccd24f566519c24452f86baec422d2197b3bc5e0'),
('sites/all/modules/contrib/views/plugins/views_plugin_cache_time.inc', '3783386fae8966111917f2311055c37f8fcad181aa438d5d0637db05dccbe0e4'),
('sites/all/modules/contrib/views/plugins/views_plugin_display.inc', 'a13858784a9e8cc0e5bda9bafb17e2a6ce48e20281134120b9ef0b7bf9fcc3b2'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_attachment.inc', 'f85f3bd80727ec6a0502393f7fdf085e4fb9d2eec4078a323c27de7b2f9328cc'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_block.inc', '1a14418a1e974d0cdacf2b3de77c46de09248e9eec26c44a6fff20f19d642b09'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_default.inc', 'd4bfea9c858c0ab9249dda27863eee45a9a43486fc8fa72a30ebf14a6b86c4ef'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_embed.inc', '400651e11fe9e0e59540eae0f6f8549b7d6f6c1aabe8818f7f6c4c11ad501bf9'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_extender.inc', 'fdb3b0cc4d6f9eedb74c92563b94a7fdfe53e0f2dac89fe212a6624ac3469f92'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_feed.inc', '2cca54e847676142123e8afff71c1d47112483e2da750489c921399d0e2a1d4c'),
('sites/all/modules/contrib/views/plugins/views_plugin_display_page.inc', 'c389d2892fba61e2689ef868a2e67da7b2807328c1f594ce7dbc5abd5c047bac'),
('sites/all/modules/contrib/views/plugins/views_plugin_exposed_form.inc', '3c7c9b281db9d5f08d9d2dd9c9d943ce1f0589a80dad9f8d00d98567cdbffcf3'),
('sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_basic.inc', '75f0c8630ec72a143e95e3695f379b0ee154d80773633f15de0ce80439e930aa'),
('sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_input_required.inc', '72f41fbb87e87b78f69639e9d81b9f0d341995c882a5a93a7a8327b0e1bc8b0a'),
('sites/all/modules/contrib/views/plugins/views_plugin_localization.inc', '157a13a1d7c6d472f2ef179f74389fa31dce9cab1897363f8c45ce9557ce12e8'),
('sites/all/modules/contrib/views/plugins/views_plugin_localization_core.inc', '8feab7c01df92b1a7c6bbfbcaf4f0adf82b6f2adcbd4f50c7680ab3f8ba648aa'),
('sites/all/modules/contrib/views/plugins/views_plugin_localization_none.inc', '9d94a95dc72ce35561697497e9a6152b0b98d2af45039385e90bc3866c70c28b'),
('sites/all/modules/contrib/views/plugins/views_plugin_pager.inc', '1d90d441e667df2d8306380305a9a054062379a74548e4e789bfbba725c1c222'),
('sites/all/modules/contrib/views/plugins/views_plugin_pager_full.inc', 'ab7a1b468a3fd28aaa0cdb3374bdac558861875604e8c8528e9352f8142a1a9d'),
('sites/all/modules/contrib/views/plugins/views_plugin_pager_mini.inc', '95802b0ef913a5d57b869075ffbcbd1912950c5bcda4cc1fd78e7715a35c6f01'),
('sites/all/modules/contrib/views/plugins/views_plugin_pager_none.inc', 'f8bb711d9edede86814821f1f6d2ca940c5b488eeb8980b0ad3b69b69a93e9a8'),
('sites/all/modules/contrib/views/plugins/views_plugin_pager_some.inc', '272f71363f2a94a32997717ef89dcc4683f63b04b8a2a01a9b6dbbea89fcf97c'),
('sites/all/modules/contrib/views/plugins/views_plugin_query.inc', 'a7e36dc3066067004199fa090602e5a9a7869711e3506b6cddb52f48184eb511'),
('sites/all/modules/contrib/views/plugins/views_plugin_query_default.inc', 'd7b858a0360579f752cfb60bd38c796342f38052f1bf8df08b4bfa1f5763ee3d'),
('sites/all/modules/contrib/views/plugins/views_plugin_row.inc', 'f525a18d9b273a890256bcd07caf6dacb1fcc2a38b65b866c16cd006e92de83d'),
('sites/all/modules/contrib/views/plugins/views_plugin_row_fields.inc', '3030f871c046548365156fdb5d7821104408fddeb327f6c685a72b213276eeae'),
('sites/all/modules/contrib/views/plugins/views_plugin_row_rss_fields.inc', 'a37c50686477ed30b3d2a8688ef418e0862ec729ae749b346cc396bcda0be392'),
('sites/all/modules/contrib/views/plugins/views_plugin_style.inc', 'a41847e71fc168dacde596d1557dd9e6d7a3a19d8b90a3a2ea785f7e7292713d');
INSERT INTO `jbqo_registry_file` (`filename`, `hash`) VALUES
('sites/all/modules/contrib/views/plugins/views_plugin_style_default.inc', '1adf156419a1d7748e3633a8ade693b995902c1eca3452c5cf06da4857a961aa'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_grid.inc', 'b055853b4a0d58ceb2e2e761b515734f952073c0bed0725794745b1343ab8573'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_jump_menu.inc', 'f8c6bb1aa5974b4067077eb27eda7f7402c5c6b276332fba1dd4fcb8122d3335'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_list.inc', 'fe74e3fecf15d8579d5e24d25be48dc4214af08775700eccc7b05b5abebbc951'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_mapping.inc', 'c078643b9c6e23e85e83cb9add17ef928556a5339b5bb55422689cdc6edf2523'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_rss.inc', 'a3e57703c3eb05dd8611ecb0d52c5d5aa516e91462cbed9d0f896528ec9ba98f'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_summary.inc', '957f53e4a431f25a653bb0b7e14e43cf568c88c9504fcc75a93c7faa91c9752e'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_summary_jump_menu.inc', '67b177fa07c38983f67e2ba5bdf2a501b06fd7506141b10e612a1f2514718254'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_summary_unformatted.inc', 'dc49a759f04a7da8dd69a88ba57796ace9960b18bd183926bae43e91b59e723a'),
('sites/all/modules/contrib/views/plugins/views_plugin_style_table.inc', '26bbbf4a72a486e5b64edeb935c89be7956ce4486c4b38db980a3e0d7ef17e49'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php', '9faae5ac5f46a46a9732f96b7d55556b048a49307188690ad4c669afc7c53033'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_comment_views_wizard.class.php', 'afde10deab03ebf2a9a92847b755520263182f726c0fe1b60b8b50a552c8c131'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_file_managed_views_wizard.class.php', 'f2ede8d652be4383ea7adf9b6587169b593af44c5b6a39690f732cb5075d21fd'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_revision_views_wizard.class.php', 'd733679e11f542d586d5fbcf3d1e09c1ea8eef83321c401bd8413986c30b847b'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_views_wizard.class.php', '86d7195aa3ef75293cfd933558a7127f6b3554db575911ed5a11b6b1b3c7c536'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_taxonomy_term_views_wizard.class.php', 'cac9cd982e2f31ad72b2c850e459423fed0c392a4a239a6dd80e31964ef5592a'),
('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_users_views_wizard.class.php', '854dd402224c6bfb6a0811a54eecc7655d13efc9b094621a5e8415ad27197048'),
('sites/all/modules/contrib/views/tests/comment/views_handler_argument_comment_user_uid.test', '8af12e2b17cd6944698471827c661a1a842bec3acd807f2a457249f6aac0bbf2'),
('sites/all/modules/contrib/views/tests/comment/views_handler_filter_comment_user_uid.test', 'd62fe3f3257efc0eaf742e3c177ea3f1bd5efb9fc8f91dc1bc5e9e6196085bd7'),
('sites/all/modules/contrib/views/tests/field/views_fieldapi.test', '09bbaab425a41fd6d40f632313280527e69e24e79b3719867dcb61ed4b583187'),
('sites/all/modules/contrib/views/tests/handlers/views_handlers.test', '44f3dd30909d43e250c726e312290a522131c7f0d3048fc5f8583fc8c5986f72'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_area_text.test', '3553a85c6d86992a17029eac182b486940393cee0c06380cf9f60ed208a57b5f'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_argument_null.test', 'e9adbe3e322cc8b536d79b5b915cab97102199abf2a14ad7a6374cfd18246372'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field.test', 'd4a833179c4f9aa57c42ef951b9e6d5a9304281e7aeb8c7dbe92ed6b24251cb4'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_boolean.test', 'c9f409147fe545a413b365ee37e0758a47291165effc76f0ae8743f84915053d'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_counter.test', '86f4514cfa72192034db1ef70723cb2b2b1ffde6e4e5fb4212ec959cd5697ba6'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_custom.test', '57d1f7d01e57f8e2a9694340684344f5e7d6d5c90bad8679aba591192c1f6a2d'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_date.test', '27f9b23bc31068a3f2a2f5b6678388dd4175b66f758b60e9a996e061a2e3a789'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_extension.test', '0f9c376f31ca47ecc0f01548d451c548ef7bebe8a07974def77e6725badda4e6'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_size.test', '9c951d86dad9df3fca72b20abcb1345a0473578324a454c75d8a5a22e8b68015'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_math.test', 'bbf418c1be15c20d4ddf09add1620f19ff91dc66611e8426a5528900ad9baf60'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_url.test', '0c0e54a93ffd5890b81807e0d0440d061f771fafc6d99943d5d9dfc4a1702686'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_field_xss.test', '17f33ec5473f0ddf8fbce6a3dfe3e65c0e51b7b13a0afc1b6d3dcf3667d4d83b'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_combine.test', '40dd1c5db7f8f225999dd1f7acd616269ad6d67155dcb8f843349597ac5a0a13'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_date.test', 'a26c239c803507d2716ad35c4b3ee6b5339628f45d46dcd2a5d505769309c503'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_equality.test', 'df783f081546df2f3f77ac69665cd95a5725bdccc5673ab35a79a59aca08ce1a'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_in_operator.test', '89420a4071677232e0eb82b184b37b818a82bdb2ff90a8b21293f9ecb21808bf'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_numeric.test', '818f73baea9d062dbc7e4ef35444c6cbb26b4b60ed3972c6d9e697162c755d05'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_string.test', '33eec214b52abf24b54fa7eae0758f9f0cd59468c11829f87f575baa2017b84e'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_manytoone.test', '42466036b7dbd70e4dba185961390b2eebfba78b6aec08a75501d8276207d4b9'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_sort.test', 'ace33efab99798d8221871038b2298b9e645f22278dd015dda5fac6688ee54ee'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_sort_date.test', '4f997b2d2afdb64747b087c7e118287bc58872d72740e5004e17e5ee6ef643c7'),
('sites/all/modules/contrib/views/tests/handlers/views_handler_sort_random.test', '9ff72485303fd209ef748c65d0cb52078400985b54f256b82f1b3bb28a323a1f'),
('sites/all/modules/contrib/views/tests/node/views_node_revision_relations.test', '108f56a3381d1c9a72f85d5a681ebeff66c587d032d13ed229dfc32c7d0195d7'),
('sites/all/modules/contrib/views/tests/plugins/views_plugin_display.test', 'fb9399398d003056fe5b7d79f67de93b6a79a2a651f1041c73d5beedf632bfde'),
('sites/all/modules/contrib/views/tests/styles/views_plugin_style.test', 'ec6258fd8ae26ac1832cf2ad9d0f5625965168126413ed6dc7798d09b658db03'),
('sites/all/modules/contrib/views/tests/styles/views_plugin_style_base.test', '54fb7816d18416d8b0db67e9f55aa2aa50ac204eb9311be14b6700b7d7a95ae7'),
('sites/all/modules/contrib/views/tests/styles/views_plugin_style_jump_menu.test', 'a78de0a289d2813b8b0c4a841c147d8e9c4a2dd6f6b8a7c89b7a62a9daee2520'),
('sites/all/modules/contrib/views/tests/styles/views_plugin_style_mapping.test', 'c0e4768100d803b5f1e48c2883ebb9951e538bd72cf4a7325a7c5c7970c2967a'),
('sites/all/modules/contrib/views/tests/styles/views_plugin_style_unformatted.test', 'd22239d0812c2f28df86b1742a0968c8ce76f120072a7bf5631b839967ff757a'),
('sites/all/modules/contrib/views/tests/taxonomy/views_handler_relationship_node_term_data.test', '6c4b72146690700987abca3f746e01278c0866438d5324263766fc4493802e12'),
('sites/all/modules/contrib/views/tests/test_handlers/views_test_area_access.inc', 'bcf28fc741476430d6904d35a81c5d11ae2b99b91a44b513fedfe452d66e2cb6'),
('sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_dynamic.inc', 'd6fbf2f48808f6347c8cb9049bc94c1762eed36e034df3bec23baad23b3454df'),
('sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_static.inc', '38578c3e1ca4cec8e75fa088fc274390baf01335c226e4791b2a498bb62b0633'),
('sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_style_test_mapping.inc', 'd5a1752b2d751359aaa6600f94f9e2cda903ffb580781cedc0ded7ea795f6024'),
('sites/all/modules/contrib/views/tests/user/views_handler_field_user_name.test', 'fa92b2055c02ea2c3cd5f9619848f299cc83a3d21638a7dd44804ea9e0644ad0'),
('sites/all/modules/contrib/views/tests/user/views_user.test', '59c88fe311319773d8d2e9d76b4f6b6f5731c86797e47760ec585295c376853c'),
('sites/all/modules/contrib/views/tests/user/views_user_argument_default.test', 'a2026a55bec3bfd84601f4c03ba5a284732f9797c61c175a906b11a8fbe8effc'),
('sites/all/modules/contrib/views/tests/user/views_user_argument_validate.test', '954b4b5886e74f20a113032734dfca6e5c1cfc068d31a5b9ba428337659a44e3'),
('sites/all/modules/contrib/views/tests/views_access.test', '3f17cc9257c3c12f24197106b27654e811801fc5d5639022e23a98c7b45e4d7f'),
('sites/all/modules/contrib/views/tests/views_ajax.test', '9741ae5e85382066f5a6401d1d85b333dedd741d13194c4dafcdc0ca81441e7b'),
('sites/all/modules/contrib/views/tests/views_analyze.test', 'f521c5e3c781d6eaf1ad58536a875c2c8cefc973a23087073653f397b7de89df'),
('sites/all/modules/contrib/views/tests/views_argument_default.test', 'de7a8eb60e71b6bc2996d636bb91aa6c9c3adca6f857300b13c1e650d07ad66e'),
('sites/all/modules/contrib/views/tests/views_argument_validator.test', '8fe3d99942cd98f981a08ab49b09eb8bb2cf1e2fb09b53dc1030abb59611edba'),
('sites/all/modules/contrib/views/tests/views_basic.test', 'e3715a9df468b1c2decb4d8a068a68ca6a3f8bd467066634075ee643d6cabb60'),
('sites/all/modules/contrib/views/tests/views_cache.test', '325ac3e8100fe1c9aa065a72bdd238c863bf51da269d2a686a36060d05ede112'),
('sites/all/modules/contrib/views/tests/views_clone.test', '99176a985b8e7ce8a83214f2a98a66394a2ebe7a852192e82f50d359bee89052'),
('sites/all/modules/contrib/views/tests/views_exposed_form.test', '0427bd048cab45f3f07aca9f96e8e8f083f464ca61975c107f63988ec9fbc9a1'),
('sites/all/modules/contrib/views/tests/views_glossary.test', 'f585ecf6a0b10d956b4010ccef44f19db11da52fa2d25380e97c4eded6ad199f'),
('sites/all/modules/contrib/views/tests/views_groupby.test', 'db01e228395517ed4d0d8fa234a63a14781068f60e54d07e40ae7ef12052394d'),
('sites/all/modules/contrib/views/tests/views_handlers.test', '87f9e7bd3afa75f79bb1f3cdfff0b76fc4199174e197459b7c3f985c8256ffcd'),
('sites/all/modules/contrib/views/tests/views_handler_filter.test', '39f2aade9f7d32ca2dd3d22fe3c36eb973695e315e8bca6dd76cb72fd5734779'),
('sites/all/modules/contrib/views/tests/views_module.test', '2640ac503d4a832258f8836459b9228a6ce39849d199d407f85ff4a9d939c7a8'),
('sites/all/modules/contrib/views/tests/views_pager.test', 'fd1e54a66c8f4c4b7bc811cf0466ea1c7bb8d961b8b592d2101ae168dbc8f613'),
('sites/all/modules/contrib/views/tests/views_plugin_localization_test.inc', 'db13bd5e57b137f6cf0d06789b2429e33b429d5e001e1e99c6afbac38944d050'),
('sites/all/modules/contrib/views/tests/views_query.test', 'e7f5b1449539805086fd2b10239c8f702851a3dbefe8e93a89d85ab75361e9ff'),
('sites/all/modules/contrib/views/tests/views_test.views_default.inc', '1245b6883b9ce5169d5ea21cd951794a33f87ed16305205a35f2157f6152ab93'),
('sites/all/modules/contrib/views/tests/views_translatable.test', '09e2091a84268085a75992b30b761c76a58b8ca2c1612e41d899c180ff8d9066'),
('sites/all/modules/contrib/views/tests/views_ui.test', 'fbd2f7ed1320f28dc7ac17949296199218f9f10ee18bdc6c35c75c75e68876fb'),
('sites/all/modules/contrib/views/tests/views_upgrade.test', 'ebebe64dc1fd8b70908e11e6ad4e7b81c4ab472d3da4773fd6f46932764fc60e'),
('sites/all/modules/contrib/views/tests/views_view.test', '9fc3e62bfa6ad01bbf71b9b2ff065466290de378bd7adc28943dba1c1364fc83');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_role`
--

CREATE TABLE `jbqo_role` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'The weight of this role in listings and the user interface.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';

--
-- Dumping data for table `jbqo_role`
--

INSERT INTO `jbqo_role` (`rid`, `name`, `weight`) VALUES
(3, 'administrator', 2),
(1, 'anonymous user', 0),
(2, 'authenticated user', 1);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_role_permission`
--

CREATE TABLE `jbqo_role_permission` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Foreign Key: `jbqo_role`.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

--
-- Dumping data for table `jbqo_role_permission`
--

INSERT INTO `jbqo_role_permission` (`rid`, `permission`, `module`) VALUES
(1, 'access comments', 'comment'),
(1, 'access content', 'node'),
(1, 'use text format filtered_html', 'filter'),
(2, 'access comments', 'comment'),
(2, 'access content', 'node'),
(2, 'post comments', 'comment'),
(2, 'skip comment approval', 'comment'),
(2, 'use text format filtered_html', 'filter'),
(3, 'access administration pages', 'system'),
(3, 'access all views', 'views'),
(3, 'access comments', 'comment'),
(3, 'access content', 'node'),
(3, 'access content overview', 'node'),
(3, 'access contextual links', 'contextual'),
(3, 'access dashboard', 'dashboard'),
(3, 'access devel information', 'devel'),
(3, 'access overlay', 'overlay'),
(3, 'access site in maintenance mode', 'system'),
(3, 'access site reports', 'system'),
(3, 'access toolbar', 'toolbar'),
(3, 'access user profiles', 'user'),
(3, 'administer actions', 'system'),
(3, 'administer blocks', 'block'),
(3, 'administer comments', 'comment'),
(3, 'administer content types', 'node'),
(3, 'administer features', 'features'),
(3, 'administer fields', 'field'),
(3, 'administer filters', 'filter'),
(3, 'administer image styles', 'image'),
(3, 'administer menu', 'menu'),
(3, 'administer modules', 'system'),
(3, 'administer nodes', 'node'),
(3, 'administer permissions', 'user'),
(3, 'administer search', 'search'),
(3, 'administer shortcuts', 'shortcut'),
(3, 'administer site configuration', 'system'),
(3, 'administer software updates', 'system'),
(3, 'administer taxonomy', 'taxonomy'),
(3, 'administer themes', 'system'),
(3, 'administer url aliases', 'path'),
(3, 'administer users', 'user'),
(3, 'administer views', 'views'),
(3, 'block IP addresses', 'system'),
(3, 'bypass node access', 'node'),
(3, 'cancel account', 'user'),
(3, 'change own username', 'user'),
(3, 'create article content', 'node'),
(3, 'create page content', 'node'),
(3, 'create url aliases', 'path'),
(3, 'customize shortcut links', 'shortcut'),
(3, 'delete any article content', 'node'),
(3, 'delete any page content', 'node'),
(3, 'delete own article content', 'node'),
(3, 'delete own page content', 'node'),
(3, 'delete revisions', 'node'),
(3, 'delete terms in 1', 'taxonomy'),
(3, 'edit any article content', 'node'),
(3, 'edit any page content', 'node'),
(3, 'edit own article content', 'node'),
(3, 'edit own comments', 'comment'),
(3, 'edit own page content', 'node'),
(3, 'edit terms in 1', 'taxonomy'),
(3, 'execute php code', 'devel'),
(3, 'generate features', 'features'),
(3, 'manage features', 'features'),
(3, 'post comments', 'comment'),
(3, 'rename features', 'features'),
(3, 'revert revisions', 'node'),
(3, 'search content', 'search'),
(3, 'select account cancellation method', 'user'),
(3, 'skip comment approval', 'comment'),
(3, 'switch shortcut sets', 'shortcut'),
(3, 'switch users', 'devel'),
(3, 'use advanced search', 'search'),
(3, 'use ctools import', 'ctools'),
(3, 'use text format filtered_html', 'filter'),
(3, 'use text format full_html', 'filter'),
(3, 'view own unpublished content', 'node'),
(3, 'view revisions', 'node'),
(3, 'view the administration theme', 'system');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_search_dataset`
--

CREATE TABLE `jbqo_search_dataset` (
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Set to force node reindexing.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';

--
-- Dumping data for table `jbqo_search_dataset`
--

INSERT INTO `jbqo_search_dataset` (`sid`, `type`, `data`, `reindex`) VALUES
(1, 'node', ' drupal test lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi lorem ipsum dolor sit amet consectetuer adipiscing elit sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat lorem ipsum dolor sit amet consectetuer adipiscing elit sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat ut wisi enim ad minim veniam quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat ut wisi enim ad minim veniam quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat  ', 0),
(2, 'node', ' testing job 1 lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet full time  ', 0),
(3, 'node', ' testing job 2 lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet part time  ', 0),
(4, 'node', ' testing job 3 lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet freelance  ', 0),
(5, 'node', ' testing job 4 lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet freelance  ', 0),
(6, 'node', ' testing job 5 lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat sed diam voluptua at vero eos et accusam et justo duo dolores et ea rebum at vero eos et accusam et justo duo dolores et ea rebum stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet stet clita kasd gubergren no sea takimata sanctus est lorem ipsum dolor sit amet full time  ', 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_search_index`
--

CREATE TABLE `jbqo_search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The `jbqo_search_total`.word that is associated with the search item.',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_search_dataset`.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The `jbqo_search_dataset`.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';

--
-- Dumping data for table `jbqo_search_index`
--

INSERT INTO `jbqo_search_index` (`word`, `sid`, `type`, `score`) VALUES
('1', 2, 'node', 26),
('2', 3, 'node', 26),
('3', 4, 'node', 26),
('4', 5, 'node', 26),
('5', 6, 'node', 26),
('accumsan', 1, 'node', 2),
('accusam', 1, 'node', 2),
('accusam', 2, 'node', 2),
('accusam', 3, 'node', 4),
('accusam', 4, 'node', 4),
('accusam', 5, 'node', 2),
('accusam', 6, 'node', 2),
('adipiscing', 1, 'node', 2),
('aliquam', 1, 'node', 2),
('aliquip', 1, 'node', 2),
('aliquyam', 1, 'node', 2),
('aliquyam', 2, 'node', 2),
('aliquyam', 3, 'node', 4),
('aliquyam', 4, 'node', 4),
('aliquyam', 5, 'node', 2),
('aliquyam', 6, 'node', 2),
('amet', 1, 'node', 6),
('amet', 2, 'node', 4),
('amet', 3, 'node', 8),
('amet', 4, 'node', 8),
('amet', 5, 'node', 4),
('amet', 6, 'node', 4),
('augue', 1, 'node', 2),
('autem', 1, 'node', 2),
('blandit', 1, 'node', 2),
('clita', 1, 'node', 2),
('clita', 2, 'node', 2),
('clita', 3, 'node', 4),
('clita', 4, 'node', 4),
('clita', 5, 'node', 2),
('clita', 6, 'node', 2),
('commodo', 1, 'node', 2),
('consectetuer', 1, 'node', 2),
('consequat', 1, 'node', 4),
('consetetur', 1, 'node', 2),
('consetetur', 2, 'node', 2),
('consetetur', 3, 'node', 4),
('consetetur', 4, 'node', 4),
('consetetur', 5, 'node', 2),
('consetetur', 6, 'node', 2),
('delenit', 1, 'node', 2),
('diam', 1, 'node', 6),
('diam', 2, 'node', 4),
('diam', 3, 'node', 8),
('diam', 4, 'node', 8),
('diam', 5, 'node', 4),
('diam', 6, 'node', 4),
('dignissim', 1, 'node', 2),
('dolor', 1, 'node', 8),
('dolor', 2, 'node', 4),
('dolor', 3, 'node', 8),
('dolor', 4, 'node', 8),
('dolor', 5, 'node', 4),
('dolor', 6, 'node', 4),
('dolore', 1, 'node', 8),
('dolore', 2, 'node', 2),
('dolore', 3, 'node', 4),
('dolore', 4, 'node', 4),
('dolore', 5, 'node', 2),
('dolore', 6, 'node', 2),
('dolores', 1, 'node', 2),
('dolores', 2, 'node', 2),
('dolores', 3, 'node', 4),
('dolores', 4, 'node', 4),
('dolores', 5, 'node', 2),
('dolores', 6, 'node', 2),
('drupal', 1, 'node', 26),
('duis', 1, 'node', 4),
('duo', 1, 'node', 2),
('duo', 2, 'node', 2),
('duo', 3, 'node', 4),
('duo', 4, 'node', 4),
('duo', 5, 'node', 2),
('duo', 6, 'node', 2),
('eirmod', 1, 'node', 2),
('eirmod', 2, 'node', 2),
('eirmod', 3, 'node', 4),
('eirmod', 4, 'node', 4),
('eirmod', 5, 'node', 2),
('eirmod', 6, 'node', 2),
('elit', 1, 'node', 2),
('elitr', 1, 'node', 2),
('elitr', 2, 'node', 2),
('elitr', 3, 'node', 4),
('elitr', 4, 'node', 4),
('elitr', 5, 'node', 2),
('elitr', 6, 'node', 2),
('enim', 1, 'node', 2),
('eos', 1, 'node', 2),
('eos', 2, 'node', 2),
('eos', 3, 'node', 4),
('eos', 4, 'node', 4),
('eos', 5, 'node', 2),
('eos', 6, 'node', 2),
('erat', 1, 'node', 4),
('erat', 2, 'node', 2),
('erat', 3, 'node', 4),
('erat', 4, 'node', 4),
('erat', 5, 'node', 2),
('erat', 6, 'node', 2),
('eros', 1, 'node', 2),
('esse', 1, 'node', 2),
('est', 1, 'node', 2),
('est', 2, 'node', 2),
('est', 3, 'node', 4),
('est', 4, 'node', 4),
('est', 5, 'node', 2),
('est', 6, 'node', 2),
('euismod', 1, 'node', 2),
('eum', 1, 'node', 2),
('exerci', 1, 'node', 2),
('facilisi', 1, 'node', 2),
('facilisis', 1, 'node', 2),
('feugait', 1, 'node', 2),
('feugiat', 1, 'node', 2),
('freelance', 4, 'node', 1),
('freelance', 5, 'node', 1),
('full', 2, 'node', 1),
('full', 6, 'node', 1),
('gubergren', 1, 'node', 2),
('gubergren', 2, 'node', 2),
('gubergren', 3, 'node', 4),
('gubergren', 4, 'node', 4),
('gubergren', 5, 'node', 2),
('gubergren', 6, 'node', 2),
('hendrerit', 1, 'node', 2),
('illum', 1, 'node', 2),
('invidunt', 1, 'node', 2),
('invidunt', 2, 'node', 2),
('invidunt', 3, 'node', 4),
('invidunt', 4, 'node', 4),
('invidunt', 5, 'node', 2),
('invidunt', 6, 'node', 2),
('ipsum', 1, 'node', 6),
('ipsum', 2, 'node', 4),
('ipsum', 3, 'node', 8),
('ipsum', 4, 'node', 8),
('ipsum', 5, 'node', 4),
('ipsum', 6, 'node', 4),
('iriure', 1, 'node', 2),
('iusto', 1, 'node', 2),
('job', 2, 'node', 26),
('job', 3, 'node', 26),
('job', 4, 'node', 26),
('job', 5, 'node', 26),
('job', 6, 'node', 26),
('justo', 1, 'node', 2),
('justo', 2, 'node', 2),
('justo', 3, 'node', 4),
('justo', 4, 'node', 4),
('justo', 5, 'node', 2),
('justo', 6, 'node', 2),
('kasd', 1, 'node', 2),
('kasd', 2, 'node', 2),
('kasd', 3, 'node', 4),
('kasd', 4, 'node', 4),
('kasd', 5, 'node', 2),
('kasd', 6, 'node', 2),
('labore', 1, 'node', 2),
('labore', 2, 'node', 2),
('labore', 3, 'node', 4),
('labore', 4, 'node', 4),
('labore', 5, 'node', 2),
('labore', 6, 'node', 2),
('laoreet', 1, 'node', 2),
('lobortis', 1, 'node', 2),
('lorem', 1, 'node', 6),
('lorem', 2, 'node', 4),
('lorem', 3, 'node', 8),
('lorem', 4, 'node', 8),
('lorem', 5, 'node', 4),
('lorem', 6, 'node', 4),
('luptatum', 1, 'node', 2),
('magna', 1, 'node', 4),
('magna', 2, 'node', 2),
('magna', 3, 'node', 4),
('magna', 4, 'node', 4),
('magna', 5, 'node', 2),
('magna', 6, 'node', 2),
('minim', 1, 'node', 2),
('molestie', 1, 'node', 2),
('nibh', 1, 'node', 2),
('nisl', 1, 'node', 2),
('nonummy', 1, 'node', 2),
('nonumy', 1, 'node', 2),
('nonumy', 2, 'node', 2),
('nonumy', 3, 'node', 4),
('nonumy', 4, 'node', 4),
('nonumy', 5, 'node', 2),
('nonumy', 6, 'node', 2),
('nostrud', 1, 'node', 2),
('nulla', 1, 'node', 4),
('odio', 1, 'node', 2),
('part', 3, 'node', 1),
('praesent', 1, 'node', 2),
('qui', 1, 'node', 2),
('quis', 1, 'node', 2),
('rebum', 1, 'node', 2),
('rebum', 2, 'node', 2),
('rebum', 3, 'node', 4),
('rebum', 4, 'node', 4),
('rebum', 5, 'node', 2),
('rebum', 6, 'node', 2),
('sadipscing', 1, 'node', 2),
('sadipscing', 2, 'node', 2),
('sadipscing', 3, 'node', 4),
('sadipscing', 4, 'node', 4),
('sadipscing', 5, 'node', 2),
('sadipscing', 6, 'node', 2),
('sanctus', 1, 'node', 2),
('sanctus', 2, 'node', 2),
('sanctus', 3, 'node', 4),
('sanctus', 4, 'node', 4),
('sanctus', 5, 'node', 2),
('sanctus', 6, 'node', 2),
('sea', 1, 'node', 2),
('sea', 2, 'node', 2),
('sea', 3, 'node', 4),
('sea', 4, 'node', 4),
('sea', 5, 'node', 2),
('sea', 6, 'node', 2),
('sed', 1, 'node', 6),
('sed', 2, 'node', 4),
('sed', 3, 'node', 8),
('sed', 4, 'node', 8),
('sed', 5, 'node', 4),
('sed', 6, 'node', 4),
('sit', 1, 'node', 6),
('sit', 2, 'node', 4),
('sit', 3, 'node', 8),
('sit', 4, 'node', 8),
('sit', 5, 'node', 4),
('sit', 6, 'node', 4),
('stet', 1, 'node', 2),
('stet', 2, 'node', 2),
('stet', 3, 'node', 4),
('stet', 4, 'node', 4),
('stet', 5, 'node', 2),
('stet', 6, 'node', 2),
('suscipit', 1, 'node', 2),
('takimata', 1, 'node', 2),
('takimata', 2, 'node', 2),
('takimata', 3, 'node', 4),
('takimata', 4, 'node', 4),
('takimata', 5, 'node', 2),
('takimata', 6, 'node', 2),
('tation', 1, 'node', 2),
('tempor', 1, 'node', 2),
('tempor', 2, 'node', 2),
('tempor', 3, 'node', 4),
('tempor', 4, 'node', 4),
('tempor', 5, 'node', 2),
('tempor', 6, 'node', 2),
('test', 1, 'node', 26),
('testing', 2, 'node', 26),
('testing', 3, 'node', 26),
('testing', 4, 'node', 26),
('testing', 5, 'node', 26),
('testing', 6, 'node', 26),
('time', 2, 'node', 1),
('time', 3, 'node', 1),
('time', 6, 'node', 1),
('tincidunt', 1, 'node', 2),
('ullamcorper', 1, 'node', 2),
('vel', 1, 'node', 4),
('velit', 1, 'node', 2),
('veniam', 1, 'node', 2),
('vero', 1, 'node', 4),
('vero', 2, 'node', 2),
('vero', 3, 'node', 4),
('vero', 4, 'node', 4),
('vero', 5, 'node', 2),
('vero', 6, 'node', 2),
('voluptua', 1, 'node', 2),
('voluptua', 2, 'node', 2),
('voluptua', 3, 'node', 4),
('voluptua', 4, 'node', 4),
('voluptua', 5, 'node', 2),
('voluptua', 6, 'node', 2),
('volutpat', 1, 'node', 2),
('vulputate', 1, 'node', 2),
('wisi', 1, 'node', 2),
('zzril', 1, 'node', 2);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_search_node_links`
--

CREATE TABLE `jbqo_search_node_links` (
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_search_dataset`.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The `jbqo_search_dataset`.type of the searchable item containing the link to the node.',
  `nid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node`.nid that this item links to.',
  `caption` longtext DEFAULT NULL COMMENT 'The text used to link to the `jbqo_node`.nid.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_search_total`
--

CREATE TABLE `jbqo_search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';

--
-- Dumping data for table `jbqo_search_total`
--

INSERT INTO `jbqo_search_total` (`word`, `count`) VALUES
('1', 0.0163904),
('2', 0.0163904),
('3', 0.0163904),
('4', 0.0163904),
('5', 0.0163904),
('accumsan', 0.176091),
('accusam', 0.0263289),
('adipiscing', 0.176091),
('aliquam', 0.176091),
('aliquip', 0.176091),
('aliquyam', 0.0263289),
('amet', 0.0125891),
('augue', 0.176091),
('autem', 0.176091),
('blandit', 0.176091),
('clita', 0.0263289),
('commodo', 0.176091),
('consectetuer', 0.176091),
('consequat', 0.09691),
('consetetur', 0.0263289),
('delenit', 0.176091),
('diam', 0.0125891),
('dignissim', 0.176091),
('dolor', 0.0118992),
('dolore', 0.0193052),
('dolores', 0.0263289),
('drupal', 0.0163904),
('duis', 0.09691),
('duo', 0.0263289),
('eirmod', 0.0263289),
('elit', 0.176091),
('elitr', 0.0263289),
('enim', 0.176091),
('eos', 0.0263289),
('erat', 0.0234811),
('eros', 0.176091),
('esse', 0.176091),
('est', 0.0263289),
('euismod', 0.176091),
('eum', 0.176091),
('exerci', 0.176091),
('facilisi', 0.176091),
('facilisis', 0.176091),
('feugait', 0.176091),
('feugiat', 0.176091),
('freelance', 0.176091),
('full', 0.124939),
('gubergren', 0.0263289),
('hendrerit', 0.176091),
('illum', 0.176091),
('invidunt', 0.0263289),
('ipsum', 0.0125891),
('iriure', 0.176091),
('iusto', 0.176091),
('job', 0.00332794),
('justo', 0.0263289),
('kasd', 0.0263289),
('labore', 0.0263289),
('laoreet', 0.176091),
('lobortis', 0.176091),
('lorem', 0.0125891),
('luptatum', 0.176091),
('magna', 0.0234811),
('minim', 0.176091),
('molestie', 0.176091),
('nibh', 0.176091),
('nisl', 0.176091),
('nonummy', 0.176091),
('nonumy', 0.0263289),
('nostrud', 0.176091),
('nulla', 0.09691),
('odio', 0.176091),
('part', 0.30103),
('praesent', 0.176091),
('qui', 0.176091),
('quis', 0.176091),
('rebum', 0.0263289),
('sadipscing', 0.0263289),
('sanctus', 0.0263289),
('sea', 0.0263289),
('sed', 0.0125891),
('sit', 0.0125891),
('stet', 0.0263289),
('suscipit', 0.176091),
('takimata', 0.0263289),
('tation', 0.176091),
('tempor', 0.0263289),
('test', 0.0163904),
('testing', 0.00332794),
('time', 0.124939),
('tincidunt', 0.176091),
('ullamcorper', 0.176091),
('vel', 0.09691),
('velit', 0.176091),
('veniam', 0.176091),
('vero', 0.0234811),
('voluptua', 0.0263289),
('volutpat', 0.176091),
('vulputate', 0.176091),
('wisi', 0.176091),
('zzril', 0.176091);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_semaphore`
--

CREATE TABLE `jbqo_semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_sequences`
--

CREATE TABLE `jbqo_sequences` (
  `value` int(10) UNSIGNED NOT NULL COMMENT 'The value of the sequence.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';

--
-- Dumping data for table `jbqo_sequences`
--

INSERT INTO `jbqo_sequences` (`value`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_sessions`
--

CREATE TABLE `jbqo_sessions` (
  `uid` int(10) UNSIGNED NOT NULL COMMENT 'The `jbqo_users`.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT 0 COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT 0 COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob DEFAULT NULL COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';

--
-- Dumping data for table `jbqo_sessions`
--

INSERT INTO `jbqo_sessions` (`uid`, `sid`, `ssid`, `hostname`, `timestamp`, `cache`, `session`) VALUES
(1, '4HXToVIQBIhD-L0WxPLaKl_8Ik8-aPfB1B_r3DIC6r4', '4HXToVIQBIhD-L0WxPLaKl_8Ik8-aPfB1B_r3DIC6r4', '178.223.112.184', 1608061764, 0, ''),
(1, 'c0cFzWOymNpFWxaNFikEEteRvRA1NDhsGWhL6w69aT4', 'c0cFzWOymNpFWxaNFikEEteRvRA1NDhsGWhL6w69aT4', '212.200.65.95', 1608106224, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_shortcut_set`
--

CREATE TABLE `jbqo_shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The `jbqo_menu_links`.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

--
-- Dumping data for table `jbqo_shortcut_set`
--

INSERT INTO `jbqo_shortcut_set` (`set_name`, `title`) VALUES
('shortcut-set-1', 'Default');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_shortcut_set_users`
--

CREATE TABLE `jbqo_shortcut_set_users` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The `jbqo_shortcut_set`.set_name that will be displayed for this user.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_system`
--

CREATE TABLE `jbqo_system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT 0 COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT -1 COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob DEFAULT NULL COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';

--
-- Dumping data for table `jbqo_system`
--

INSERT INTO `jbqo_system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/aggregator/aggregator.module', 'aggregator', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31303a2241676772656761746f72223b733a31313a226465736372697074696f6e223b733a35373a22416767726567617465732073796e6469636174656420636f6e74656e7420285253532c205244462c20616e642041746f6d206665656473292e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a2261676772656761746f722e74657374223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f73657276696365732f61676772656761746f722f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31343a2261676772656761746f722e637373223b733a33333a226d6f64756c65732f61676772656761746f722f61676772656761746f722e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/aggregator/tests/aggregator_test.module', 'aggregator_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a2241676772656761746f72206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a34363a22537570706f7274206d6f64756c6520666f722061676772656761746f722072656c617465642074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/block/block.module', 'block', 'module', '', 1, 0, 7009, -5, 0x613a31333a7b733a343a226e616d65223b733a353a22426c6f636b223b733a31313a226465736372697074696f6e223b733a3134303a22436f6e74726f6c73207468652076697375616c206275696c64696e6720626c6f636b732061207061676520697320636f6e737472756374656420776974682e20426c6f636b732061726520626f786573206f6620636f6e74656e742072656e646572656420696e746f20616e20617265612c206f7220726567696f6e2c206f6620612077656220706167652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22626c6f636b2e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f626c6f636b223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/block/tests/block_test.module', 'block_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22426c6f636b2074657374223b733a31313a226465736372697074696f6e223b733a32313a2250726f7669646573207465737420626c6f636b732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/blog/blog.module', 'blog', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a343a22426c6f67223b733a31313a226465736372697074696f6e223b733a32353a22456e61626c6573206d756c74692d7573657220626c6f67732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22626c6f672e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/book/book.module', 'book', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a343a22426f6f6b223b733a31313a226465736372697074696f6e223b733a36363a22416c6c6f777320757365727320746f2063726561746520616e64206f7267616e697a652072656c6174656420636f6e74656e7420696e20616e206f75746c696e652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22626f6f6b2e74657374223b7d733a393a22636f6e666967757265223b733a32373a2261646d696e2f636f6e74656e742f626f6f6b2f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22626f6f6b2e637373223b733a32313a226d6f64756c65732f626f6f6b2f626f6f6b2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/color/color.module', 'color', 'module', '', 1, 0, 7001, 0, 0x613a31323a7b733a343a226e616d65223b733a353a22436f6c6f72223b733a31313a226465736372697074696f6e223b733a37303a22416c6c6f77732061646d696e6973747261746f727320746f206368616e67652074686520636f6c6f7220736368656d65206f6620636f6d70617469626c65207468656d65732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22636f6c6f722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/comment/comment.module', 'comment', 'module', '', 1, 0, 7009, 0, 0x613a31343a7b733a343a226e616d65223b733a373a22436f6d6d656e74223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f777320757365727320746f20636f6d6d656e74206f6e20616e642064697363757373207075626c697368656420636f6e74656e742e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a2274657874223b7d733a353a2266696c6573223b613a323a7b693a303b733a31343a22636f6d6d656e742e6d6f64756c65223b693a313b733a31323a22636f6d6d656e742e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f636f6e74656e742f636f6d6d656e74223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31313a22636f6d6d656e742e637373223b733a32373a226d6f64756c65732f636f6d6d656e742f636f6d6d656e742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/contact/contact.module', 'contact', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a22436f6e74616374223b733a31313a226465736372697074696f6e223b733a36313a22456e61626c65732074686520757365206f6620626f746820706572736f6e616c20616e6420736974652d7769646520636f6e7461637420666f726d732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22636f6e746163742e74657374223b7d733a393a22636f6e666967757265223b733a32333a2261646d696e2f7374727563747572652f636f6e74616374223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/contextual/contextual.module', 'contextual', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a31363a22436f6e7465787475616c206c696e6b73223b733a31313a226465736372697074696f6e223b733a37353a2250726f766964657320636f6e7465787475616c206c696e6b7320746f20706572666f726d20616374696f6e732072656c6174656420746f20656c656d656e7473206f6e206120706167652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a22636f6e7465787475616c2e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/dashboard/dashboard.module', 'dashboard', 'module', '', 0, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2244617368626f617264223b733a31313a226465736372697074696f6e223b733a3133363a2250726f766964657320612064617368626f617264207061676520696e207468652061646d696e69737472617469766520696e7465726661636520666f72206f7267616e697a696e672061646d696e697374726174697665207461736b7320616e6420747261636b696e6720696e666f726d6174696f6e2077697468696e20796f757220736974652e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a353a2266696c6573223b613a313a7b693a303b733a31343a2264617368626f6172642e74657374223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a22626c6f636b223b7d733a393a22636f6e666967757265223b733a32353a2261646d696e2f64617368626f6172642f637573746f6d697a65223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/dblog/dblog.module', 'dblog', 'module', '', 1, 1, 7003, 0, 0x613a31323a7b733a343a226e616d65223b733a31363a224461746162617365206c6f6767696e67223b733a31313a226465736372697074696f6e223b733a34373a224c6f677320616e64207265636f7264732073797374656d206576656e747320746f207468652064617461626173652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a2264626c6f672e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/field.module', 'field', 'module', '', 1, 0, 7004, 0, 0x613a31343a7b733a343a226e616d65223b733a353a224669656c64223b733a31313a226465736372697074696f6e223b733a35373a224669656c642041504920746f20616464206669656c647320746f20656e746974696573206c696b65206e6f64657320616e642075736572732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a343a7b693a303b733a31323a226669656c642e6d6f64756c65223b693a313b733a31363a226669656c642e6174746163682e696e63223b693a323b733a32303a226669656c642e696e666f2e636c6173732e696e63223b693a333b733a31363a2274657374732f6669656c642e74657374223b7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31373a226669656c645f73716c5f73746f72616765223b7d733a383a227265717569726564223b623a313b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31353a227468656d652f6669656c642e637373223b733a32393a226d6f64756c65732f6669656c642f7468656d652f6669656c642e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/field_sql_storage/field_sql_storage.module', 'field_sql_storage', 'module', '', 1, 0, 7002, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224669656c642053514c2073746f72616765223b733a31313a226465736372697074696f6e223b733a33373a2253746f726573206669656c64206461746120696e20616e2053514c2064617461626173652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a32323a226669656c645f73716c5f73746f726167652e74657374223b7d733a383a227265717569726564223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/list/list.module', 'list', 'module', '', 1, 0, 7002, 0, 0x613a31343a7b733a343a226e616d65223b733a343a224c697374223b733a31313a226465736372697074696f6e223b733a36393a22446566696e6573206c697374206669656c642074797065732e205573652077697468204f7074696f6e7320746f206372656174652073656c656374696f6e206c697374732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a353a226669656c64223b693a313b733a373a226f7074696f6e73223b7d733a353a2266696c6573223b613a313a7b693a303b733a31353a2274657374732f6c6973742e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/field/modules/list/tests/list_test.module', 'list_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a224c6973742074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220746865204c697374206d6f64756c652074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/number/number.module', 'number', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a363a224e756d626572223b733a31313a226465736372697074696f6e223b733a32383a22446566696e6573206e756d65726963206669656c642074797065732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31313a226e756d6265722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/options/options.module', 'options', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a224f7074696f6e73223b733a31313a226465736372697074696f6e223b733a38323a22446566696e65732073656c656374696f6e2c20636865636b20626f7820616e6420726164696f20627574746f6e207769646765747320666f72207465787420616e64206e756d65726963206669656c64732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31323a226f7074696f6e732e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field/modules/text/text.module', 'text', 'module', '', 1, 0, 7000, 0, 0x613a31343a7b733a343a226e616d65223b733a343a2254657874223b733a31313a226465736372697074696f6e223b733a33323a22446566696e65732073696d706c652074657874206669656c642074797065732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a393a22746578742e74657374223b7d733a383a227265717569726564223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/field/tests/field_test.module', 'field_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224669656c64204150492054657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220746865204669656c64204150492074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a353a2266696c6573223b613a313a7b693a303b733a32313a226669656c645f746573742e656e746974792e696e63223b7d733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/field_ui/field_ui.module', 'field_ui', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a383a224669656c64205549223b733a31313a226465736372697074696f6e223b733a33333a225573657220696e7465726661636520666f7220746865204669656c64204150492e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31333a226669656c645f75692e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/file/file.module', 'file', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a343a2246696c65223b733a31313a226465736372697074696f6e223b733a32363a22446566696e657320612066696c65206669656c6420747970652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a226669656c64223b7d733a353a2266696c6573223b613a313a7b693a303b733a31353a2274657374732f66696c652e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/file/tests/file_module_test.module', 'file_module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2246696c652074657374223b733a31313a226465736372697074696f6e223b733a35333a2250726f766964657320686f6f6b7320666f722074657374696e672046696c65206d6f64756c652066756e6374696f6e616c6974792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/filter/filter.module', 'filter', 'module', '', 1, 0, 7010, 0, 0x613a31343a7b733a343a226e616d65223b733a363a2246696c746572223b733a31313a226465736372697074696f6e223b733a34333a2246696c7465727320636f6e74656e7420696e207072657061726174696f6e20666f7220646973706c61792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a2266696c7465722e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a32383a2261646d696e2f636f6e6669672f636f6e74656e742f666f726d617473223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/forum/forum.module', 'forum', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a353a22466f72756d223b733a31313a226465736372697074696f6e223b733a32373a2250726f76696465732064697363757373696f6e20666f72756d732e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a383a227461786f6e6f6d79223b693a313b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31303a22666f72756d2e74657374223b7d733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f666f72756d223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a393a22666f72756d2e637373223b733a32333a226d6f64756c65732f666f72756d2f666f72756d2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/help/help.module', 'help', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a343a2248656c70223b733a31313a226465736372697074696f6e223b733a33353a224d616e616765732074686520646973706c6179206f66206f6e6c696e652068656c702e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a2268656c702e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/image/image.module', 'image', 'module', '', 1, 0, 7005, 0, 0x613a31353a7b733a343a226e616d65223b733a353a22496d616765223b733a31313a226465736372697074696f6e223b733a33343a2250726f766964657320696d616765206d616e6970756c6174696f6e20746f6f6c732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a2266696c65223b7d733a353a2266696c6573223b613a313a7b693a303b733a31303a22696d6167652e74657374223b7d733a393a22636f6e666967757265223b733a33313a2261646d696e2f636f6e6669672f6d656469612f696d6167652d7374796c6573223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/image/tests/image_module_test.module', 'image_module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22496d6167652074657374223b733a31313a226465736372697074696f6e223b733a36393a2250726f766964657320686f6f6b20696d706c656d656e746174696f6e7320666f722074657374696e6720496d616765206d6f64756c652066756e6374696f6e616c6974792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a32343a22696d6167655f6d6f64756c655f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/locale/locale.module', 'locale', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a363a224c6f63616c65223b733a31313a226465736372697074696f6e223b733a3131393a2241646473206c616e67756167652068616e646c696e672066756e6374696f6e616c69747920616e6420656e61626c657320746865207472616e736c6174696f6e206f6620746865207573657220696e7465726661636520746f206c616e677561676573206f74686572207468616e20456e676c6973682e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a226c6f63616c652e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f726567696f6e616c2f6c616e6775616765223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/locale/tests/locale_test.module', 'locale_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a224c6f63616c652054657374223b733a31313a226465736372697074696f6e223b733a34323a22537570706f7274206d6f64756c6520666f7220746865206c6f63616c65206c617965722074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/menu/menu.module', 'menu', 'module', '', 1, 0, 7003, 0, 0x613a31333a7b733a343a226e616d65223b733a343a224d656e75223b733a31313a226465736372697074696f6e223b733a36303a22416c6c6f77732061646d696e6973747261746f727320746f20637573746f6d697a65207468652073697465206e617669676174696f6e206d656e752e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a226d656e752e74657374223b7d733a393a22636f6e666967757265223b733a32303a2261646d696e2f7374727563747572652f6d656e75223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/node/node.module', 'node', 'module', '', 1, 0, 7016, 0, 0x613a31353a7b733a343a226e616d65223b733a343a224e6f6465223b733a31313a226465736372697074696f6e223b733a36363a22416c6c6f777320636f6e74656e7420746f206265207375626d697474656420746f20746865207369746520616e6420646973706c61796564206f6e2070616765732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31313a226e6f64652e6d6f64756c65223b693a313b733a393a226e6f64652e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f7479706573223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a226e6f64652e637373223b733a32313a226d6f64756c65732f6e6f64652f6e6f64652e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_access_test.module', 'node_access_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a224e6f6465206d6f64756c6520616363657373207465737473223b733a31313a226465736372697074696f6e223b733a34333a22537570706f7274206d6f64756c6520666f72206e6f6465207065726d697373696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_test.module', 'node_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a224e6f6465206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72206e6f64652072656c617465642074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/node/tests/node_test_exception.module', 'node_test_exception', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32373a224e6f6465206d6f64756c6520657863657074696f6e207465737473223b733a31313a226465736372697074696f6e223b733a35303a22537570706f7274206d6f64756c6520666f72206e6f64652072656c6174656420657863657074696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/openid/openid.module', 'openid', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a363a224f70656e4944223b733a31313a226465736372697074696f6e223b733a34383a22416c6c6f777320757365727320746f206c6f6720696e746f20796f75722073697465207573696e67204f70656e49442e223b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a227061636b616765223b733a343a22436f7265223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a226f70656e69642e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/openid/tests/openid_test.module', 'openid_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224f70656e49442064756d6d792070726f7669646572223b733a31313a226465736372697074696f6e223b733a33333a224f70656e49442070726f7669646572207573656420666f722074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a226f70656e6964223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/overlay/overlay.module', 'overlay', 'module', '', 0, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a224f7665726c6179223b733a31313a226465736372697074696f6e223b733a35393a22446973706c617973207468652044727570616c2061646d696e697374726174696f6e20696e7465726661636520696e20616e206f7665726c61792e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/path/path.module', 'path', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a343a2250617468223b733a31313a226465736372697074696f6e223b733a32383a22416c6c6f777320757365727320746f2072656e616d652055524c732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22706174682e74657374223b7d733a393a22636f6e666967757265223b733a32343a2261646d696e2f636f6e6669672f7365617263682f70617468223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/php/php.module', 'php', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31303a225048502066696c746572223b733a31313a226465736372697074696f6e223b733a35303a22416c6c6f777320656d6265646465642050485020636f64652f736e69707065747320746f206265206576616c75617465642e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a383a227068702e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/poll/poll.module', 'poll', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a343a22506f6c6c223b733a31313a226465736372697074696f6e223b733a39353a22416c6c6f777320796f7572207369746520746f206361707475726520766f746573206f6e20646966666572656e7420746f7069637320696e2074686520666f726d206f66206d756c7469706c652063686f696365207175657374696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a393a22706f6c6c2e74657374223b7d733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22706f6c6c2e637373223b733a32313a226d6f64756c65732f706f6c6c2f706f6c6c2e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/profile/profile.module', 'profile', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a373a2250726f66696c65223b733a31313a226465736372697074696f6e223b733a33363a22537570706f72747320636f6e666967757261626c6520757365722070726f66696c65732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a2270726f66696c652e74657374223b7d733a393a22636f6e666967757265223b733a32373a2261646d696e2f636f6e6669672f70656f706c652f70726f66696c65223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/rdf/rdf.module', 'rdf', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a333a22524446223b733a31313a226465736372697074696f6e223b733a3134383a22456e72696368657320796f757220636f6e74656e742077697468206d6574616461746120746f206c6574206f74686572206170706c69636174696f6e732028652e672e2073656172636820656e67696e65732c2061676772656761746f7273292062657474657220756e6465727374616e64206974732072656c6174696f6e736869707320616e6420617474726962757465732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a383a227264662e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/rdf/tests/rdf_test.module', 'rdf_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a22524446206d6f64756c65207465737473223b733a31313a226465736372697074696f6e223b733a33383a22537570706f7274206d6f64756c6520666f7220524446206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a22626c6f67223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/search.module', 'search', 'module', '', 1, 0, 7000, 0, 0x613a31343a7b733a343a226e616d65223b733a363a22536561726368223b733a31313a226465736372697074696f6e223b733a33363a22456e61626c657320736974652d77696465206b6579776f726420736561726368696e672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31393a227365617263682e657874656e6465722e696e63223b693a313b733a31313a227365617263682e74657374223b7d733a393a22636f6e666967757265223b733a32383a2261646d696e2f636f6e6669672f7365617263682f73657474696e6773223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a227365617263682e637373223b733a32353a226d6f64756c65732f7365617263682f7365617263682e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_embedded_form.module', 'search_embedded_form', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32303a2253656172636820656d62656464656420666f726d223b733a31313a226465736372697074696f6e223b733a35393a22537570706f7274206d6f64756c6520666f7220736561726368206d6f64756c652074657374696e67206f6620656d62656464656420666f726d732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_extra_type.module', 'search_extra_type', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a2254657374207365617263682074797065223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220736561726368206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/search/tests/search_node_tags.module', 'search_node_tags', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a225465737420736561726368206e6f64652074616773223b733a31313a226465736372697074696f6e223b733a34343a22537570706f7274206d6f64756c6520666f72204e6f64652073656172636820746167732074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/shortcut/shortcut.module', 'shortcut', 'module', '', 1, 0, 0, 0, 0x613a31333a7b733a343a226e616d65223b733a383a2253686f7274637574223b733a31313a226465736372697074696f6e223b733a36303a22416c6c6f777320757365727320746f206d616e61676520637573746f6d697a61626c65206c69737473206f662073686f7274637574206c696e6b732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31333a2273686f72746375742e74657374223b7d733a393a22636f6e666967757265223b733a33363a2261646d696e2f636f6e6669672f757365722d696e746572666163652f73686f7274637574223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `jbqo_system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/simpletest/simpletest.module', 'simpletest', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a2254657374696e67223b733a31313a226465736372697074696f6e223b733a35333a2250726f76696465732061206672616d65776f726b20666f7220756e697420616e642066756e6374696f6e616c2074657374696e672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a35313a7b693a303b733a31353a2273696d706c65746573742e74657374223b693a313b733a32343a2264727570616c5f7765625f746573745f636173652e706870223b693a323b733a31383a2274657374732f616374696f6e732e74657374223b693a333b733a31353a2274657374732f616a61782e74657374223b693a343b733a31363a2274657374732f62617463682e74657374223b693a353b733a31353a2274657374732f626f6f742e74657374223b693a363b733a32303a2274657374732f626f6f7473747261702e74657374223b693a373b733a31363a2274657374732f63616368652e74657374223b693a383b733a31373a2274657374732f636f6d6d6f6e2e74657374223b693a393b733a32343a2274657374732f64617461626173655f746573742e74657374223b693a31303b733a32323a2274657374732f656e746974795f637275642e74657374223b693a31313b733a33323a2274657374732f656e746974795f637275645f686f6f6b5f746573742e74657374223b693a31323b733a32333a2274657374732f656e746974795f71756572792e74657374223b693a31333b733a31363a2274657374732f6572726f722e74657374223b693a31343b733a31353a2274657374732f66696c652e74657374223b693a31353b733a32333a2274657374732f66696c657472616e736665722e74657374223b693a31363b733a31353a2274657374732f666f726d2e74657374223b693a31373b733a31363a2274657374732f67726170682e74657374223b693a31383b733a31363a2274657374732f696d6167652e74657374223b693a31393b733a31353a2274657374732f6c6f636b2e74657374223b693a32303b733a31353a2274657374732f6d61696c2e74657374223b693a32313b733a31353a2274657374732f6d656e752e74657374223b693a32323b733a31373a2274657374732f6d6f64756c652e74657374223b693a32333b733a31363a2274657374732f70616765722e74657374223b693a32343b733a31393a2274657374732f70617373776f72642e74657374223b693a32353b733a31353a2274657374732f706174682e74657374223b693a32363b733a31393a2274657374732f72656769737472792e74657374223b693a32373b733a32383a2274657374732f726571756573745f73616e6974697a65722e74657374223b693a32383b733a31373a2274657374732f736368656d612e74657374223b693a32393b733a31383a2274657374732f73657373696f6e2e74657374223b693a33303b733a32303a2274657374732f7461626c65736f72742e74657374223b693a33313b733a31363a2274657374732f7468656d652e74657374223b693a33323b733a31383a2274657374732f756e69636f64652e74657374223b693a33333b733a31373a2274657374732f7570646174652e74657374223b693a33343b733a31373a2274657374732f786d6c7270632e74657374223b693a33353b733a32363a2274657374732f757067726164652f757067726164652e74657374223b693a33363b733a33343a2274657374732f757067726164652f757067726164652e636f6d6d656e742e74657374223b693a33373b733a33333a2274657374732f757067726164652f757067726164652e66696c7465722e74657374223b693a33383b733a33323a2274657374732f757067726164652f757067726164652e666f72756d2e74657374223b693a33393b733a33333a2274657374732f757067726164652f757067726164652e6c6f63616c652e74657374223b693a34303b733a33313a2274657374732f757067726164652f757067726164652e6d656e752e74657374223b693a34313b733a33313a2274657374732f757067726164652f757067726164652e6e6f64652e74657374223b693a34323b733a33353a2274657374732f757067726164652f757067726164652e7461786f6e6f6d792e74657374223b693a34333b733a33343a2274657374732f757067726164652f757067726164652e747269676765722e74657374223b693a34343b733a33393a2274657374732f757067726164652f757067726164652e7472616e736c617461626c652e74657374223b693a34353b733a33333a2274657374732f757067726164652f757067726164652e75706c6f61642e74657374223b693a34363b733a33313a2274657374732f757067726164652f757067726164652e757365722e74657374223b693a34373b733a33363a2274657374732f757067726164652f7570646174652e61676772656761746f722e74657374223b693a34383b733a33333a2274657374732f757067726164652f7570646174652e747269676765722e74657374223b693a34393b733a33313a2274657374732f757067726164652f7570646174652e6669656c642e74657374223b693a35303b733a33303a2274657374732f757067726164652f7570646174652e757365722e74657374223b7d733a393a22636f6e666967757265223b733a34313a2261646d696e2f636f6e6669672f646576656c6f706d656e742f74657374696e672f73657474696e6773223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/actions_loop_test.module', 'actions_loop_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a22416374696f6e73206c6f6f702074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220616374696f6e206c6f6f702074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/ajax_forms_test.module', 'ajax_forms_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32363a22414a415820666f726d2074657374206d6f636b206d6f64756c65223b733a31313a226465736372697074696f6e223b733a32353a225465737420666f7220414a415820666f726d2063616c6c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/ajax_test.module', 'ajax_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a22414a41582054657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f7220414a4158206672616d65776f726b2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/batch_test.module', 'batch_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a224261746368204150492074657374223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72204261746368204150492074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/boot_test_1.module', 'boot_test_1', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224561726c7920626f6f747374726170207465737473223b733a31313a226465736372697074696f6e223b733a33393a224120737570706f7274206d6f64756c6520666f7220686f6f6b5f626f6f742074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/boot_test_2.module', 'boot_test_2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32313a224561726c7920626f6f747374726170207465737473223b733a31313a226465736372697074696f6e223b733a34343a224120737570706f7274206d6f64756c6520666f7220686f6f6b5f626f6f7420686f6f6b2074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/common_test.module', 'common_test', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31313a22436f6d6d6f6e2054657374223b733a31313a226465736372697074696f6e223b733a33323a22537570706f7274206d6f64756c6520666f7220436f6d6d6f6e2074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a31353a22636f6d6d6f6e5f746573742e637373223b733a34303a226d6f64756c65732f73696d706c65746573742f74657374732f636f6d6d6f6e5f746573742e637373223b7d733a353a227072696e74223b613a313a7b733a32313a22636f6d6d6f6e5f746573742e7072696e742e637373223b733a34363a226d6f64756c65732f73696d706c65746573742f74657374732f636f6d6d6f6e5f746573742e7072696e742e637373223b7d7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/common_test_cron_helper.module', 'common_test_cron_helper', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32333a22436f6d6d6f6e20546573742043726f6e2048656c706572223b733a31313a226465736372697074696f6e223b733a35363a2248656c706572206d6f64756c6520666f722043726f6e52756e54657374436173653a3a7465737443726f6e457863657074696f6e7328292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/database_test.module', 'database_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31333a2244617461626173652054657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72204461746162617365206c617965722074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_autoload_test/drupal_autoload_test.module', 'drupal_autoload_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32353a2244727570616c20636f64652072656769737472792074657374223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f722074657374696e672074686520636f64652072656769737472792e223b733a353a2266696c6573223b613a323a7b693a303b733a33343a2264727570616c5f6175746f6c6f61645f746573745f696e746572666163652e696e63223b693a313b733a33303a2264727570616c5f6175746f6c6f61645f746573745f636c6173732e696e63223b7d733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module', 'drupal_system_listing_compatible_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33373a2244727570616c2073797374656d206c697374696e6720636f6d70617469626c652074657374223b733a31313a226465736372697074696f6e223b733a36323a22537570706f7274206d6f64756c6520666f722074657374696e67207468652064727570616c5f73797374656d5f6c697374696e672066756e6374696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module', 'drupal_system_listing_incompatible_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33393a2244727570616c2073797374656d206c697374696e6720696e636f6d70617469626c652074657374223b733a31313a226465736372697074696f6e223b733a36323a22537570706f7274206d6f64756c6520666f722074657374696e67207468652064727570616c5f73797374656d5f6c697374696e672066756e6374696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_cache_test.module', 'entity_cache_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31373a22456e746974792063616368652074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f722074657374696e6720656e746974792063616368652e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a32383a22656e746974795f63616368655f746573745f646570656e64656e6379223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_cache_test_dependency.module', 'entity_cache_test_dependency', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32383a22456e74697479206361636865207465737420646570656e64656e6379223b733a31313a226465736372697074696f6e223b733a35313a22537570706f727420646570656e64656e6379206d6f64756c6520666f722074657374696e6720656e746974792063616368652e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_crud_hook_test.module', 'entity_crud_hook_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a22456e74697479204352554420486f6f6b732054657374223b733a31313a226465736372697074696f6e223b733a33353a22537570706f7274206d6f64756c6520666f72204352554420686f6f6b2074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/entity_query_access_test.module', 'entity_query_access_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a22456e74697479207175657279206163636573732074657374223b733a31313a226465736372697074696f6e223b733a34393a22537570706f7274206d6f64756c6520666f7220636865636b696e6720656e7469747920717565727920726573756c74732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/error_test.module', 'error_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a224572726f722074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f72206572726f7220616e6420657863657074696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/file_test.module', 'file_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a393a2246696c652074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f722066696c652068616e646c696e672074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31363a2266696c655f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/filter_test.module', 'filter_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a2246696c7465722074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a33333a2254657374732066696c74657220686f6f6b7320616e642066756e6374696f6e732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/form_test.module', 'form_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22466f726d4150492054657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f7220466f726d204150492074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/image_test.module', 'image_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a22496d6167652074657374223b733a31313a226465736372697074696f6e223b733a33393a22537570706f7274206d6f64756c6520666f7220696d61676520746f6f6c6b69742074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/menu_test.module', 'menu_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22486f6f6b206d656e75207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72206d656e7520686f6f6b2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/module_test.module', 'module_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a224d6f64756c652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f72206d6f64756c652073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/path_test.module', 'path_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22486f6f6b2070617468207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72207061746820686f6f6b2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/psr_0_test/psr_0_test.module', 'psr_0_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a225053522d302054657374206361736573223b733a31313a226465736372697074696f6e223b733a34343a225465737420636c617373657320746f20626520646973636f76657265642062792073696d706c65746573742e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/psr_4_test/psr_4_test.module', 'psr_4_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a225053522d342054657374206361736573223b733a31313a226465736372697074696f6e223b733a34343a225465737420636c617373657320746f20626520646973636f76657265642062792073696d706c65746573742e223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/requirements1_test.module', 'requirements1_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31393a22526571756972656d656e747320312054657374223b733a31313a226465736372697074696f6e223b733a38303a22546573747320746861742061206d6f64756c65206973206e6f7420696e7374616c6c6564207768656e206974206661696c7320686f6f6b5f726571756972656d656e74732827696e7374616c6c27292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/requirements2_test.module', 'requirements2_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31393a22526571756972656d656e747320322054657374223b733a31313a226465736372697074696f6e223b733a39383a22546573747320746861742061206d6f64756c65206973206e6f7420696e7374616c6c6564207768656e20746865206f6e6520697420646570656e6473206f6e206661696c7320686f6f6b5f726571756972656d656e74732827696e7374616c6c292e223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a31383a22726571756972656d656e7473315f74657374223b693a313b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/session_test.module', 'session_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a2253657373696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f722073657373696f6e20646174612074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_dependencies_test.module', 'system_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a2253797374656d20646570656e64656e63792074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31393a225f6d697373696e675f646570656e64656e6379223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module', 'system_incompatible_core_version_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a35303a2253797374656d20696e636f6d70617469626c6520636f72652076657273696f6e20646570656e64656e636965732074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a33373a2273797374656d5f696e636f6d70617469626c655f636f72655f76657273696f6e5f74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_core_version_test.module', 'system_incompatible_core_version_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33373a2253797374656d20696e636f6d70617469626c6520636f72652076657273696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22352e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module', 'system_incompatible_module_version_dependencies_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a35323a2253797374656d20696e636f6d70617469626c65206d6f64756c652076657273696f6e20646570656e64656e636965732074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a34363a2273797374656d5f696e636f6d70617469626c655f6d6f64756c655f76657273696f6e5f7465737420283e322e3029223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_incompatible_module_version_test.module', 'system_incompatible_module_version_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33393a2253797374656d20696e636f6d70617469626c65206d6f64756c652076657273696f6e2074657374223b733a31313a226465736372697074696f6e223b733a34373a22537570706f7274206d6f64756c6520666f722074657374696e672073797374656d20646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_project_namespace_test.module', 'system_project_namespace_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32393a2253797374656d2070726f6a656374206e616d6573706163652074657374223b733a31313a226465736372697074696f6e223b733a35383a22537570706f7274206d6f64756c6520666f722074657374696e672070726f6a656374206e616d65737061636520646570656e64656e636965732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a31333a2264727570616c3a66696c746572223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/system_test.module', 'system_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a2253797374656d2074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f722073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31383a2273797374656d5f746573742e6d6f64756c65223b7d733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/taxonomy_test.module', 'taxonomy_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32303a225461786f6e6f6d792074657374206d6f64756c65223b733a31313a226465736372697074696f6e223b733a34353a222254657374732066756e6374696f6e7320616e6420686f6f6b73206e6f74207573656420696e20636f7265222e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a383a227461786f6e6f6d79223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/theme_test.module', 'theme_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a225468656d652074657374223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f72207468656d652073797374656d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_script_test.module', 'update_script_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a22557064617465207363726970742074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465207363726970742074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_1.module', 'update_test_1', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_2.module', 'update_test_2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/update_test_3.module', 'update_test_3', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a33343a22537570706f7274206d6f64756c6520666f72207570646174652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/url_alter_test.module', 'url_alter_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a2255726c5f616c746572207465737473223b733a31313a226465736372697074696f6e223b733a34353a224120737570706f7274206d6f64756c657320666f722075726c5f616c74657220686f6f6b2074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/simpletest/tests/xmlrpc_test.module', 'xmlrpc_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22584d4c2d5250432054657374223b733a31313a226465736372697074696f6e223b733a37353a22537570706f7274206d6f64756c6520666f7220584d4c2d525043207465737473206163636f7264696e6720746f207468652076616c696461746f72312073706563696669636174696f6e2e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/statistics/statistics.module', 'statistics', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a2253746174697374696373223b733a31313a226465736372697074696f6e223b733a33373a224c6f677320616363657373207374617469737469637320666f7220796f757220736974652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31353a22737461746973746963732e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f73797374656d2f73746174697374696373223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/syslog/syslog.module', 'syslog', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a363a225379736c6f67223b733a31313a226465736372697074696f6e223b733a34313a224c6f677320616e64207265636f7264732073797374656d206576656e747320746f207379736c6f672e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a227379736c6f672e74657374223b7d733a393a22636f6e666967757265223b733a33323a2261646d696e2f636f6e6669672f646576656c6f706d656e742f6c6f6767696e67223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/system/system.module', 'system', 'module', '', 1, 1, 7084, 0, 0x613a31343a7b733a343a226e616d65223b733a363a2253797374656d223b733a31313a226465736372697074696f6e223b733a35343a2248616e646c65732067656e6572616c207369746520636f6e66696775726174696f6e20666f722061646d696e6973747261746f72732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a363a7b693a303b733a31393a2273797374656d2e61726368697665722e696e63223b693a313b733a31353a2273797374656d2e6d61696c2e696e63223b693a323b733a31363a2273797374656d2e71756575652e696e63223b693a333b733a31343a2273797374656d2e7461722e696e63223b693a343b733a31383a2273797374656d2e757064617465722e696e63223b693a353b733a31313a2273797374656d2e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a31393a2261646d696e2f636f6e6669672f73797374656d223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/system/tests/cron_queue_test.module', 'cron_queue_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a2243726f6e2051756575652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f72207468652063726f6e2071756575652072756e6e65722e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/system/tests/system_cron_test.module', 'system_cron_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31363a2253797374656d2043726f6e2054657374223b733a31313a226465736372697074696f6e223b733a34353a22537570706f7274206d6f64756c6520666f722074657374696e67207468652073797374656d5f63726f6e28292e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `jbqo_system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('modules/taxonomy/taxonomy.module', 'taxonomy', 'module', '', 1, 0, 7011, 0, 0x613a31353a7b733a343a226e616d65223b733a383a225461786f6e6f6d79223b733a31313a226465736372697074696f6e223b733a33383a22456e61626c6573207468652063617465676f72697a6174696f6e206f6620636f6e74656e742e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a226f7074696f6e73223b7d733a353a2266696c6573223b613a323a7b693a303b733a31353a227461786f6e6f6d792e6d6f64756c65223b693a313b733a31333a227461786f6e6f6d792e74657374223b7d733a393a22636f6e666967757265223b733a32343a2261646d696e2f7374727563747572652f7461786f6e6f6d79223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b733a383a227265717569726564223b623a313b733a31313a226578706c616e6174696f6e223b733a37333a224669656c64207479706528732920696e20757365202d20736565203c6120687265663d222f61646d696e2f7265706f7274732f6669656c6473223e4669656c64206c6973743c2f613e223b7d),
('modules/toolbar/toolbar.module', 'toolbar', 'module', '', 1, 0, 0, 0, 0x613a31323a7b733a343a226e616d65223b733a373a22546f6f6c626172223b733a31313a226465736372697074696f6e223b733a39393a2250726f7669646573206120746f6f6c62617220746861742073686f77732074686520746f702d6c6576656c2061646d696e697374726174696f6e206d656e75206974656d7320616e64206c696e6b732066726f6d206f74686572206d6f64756c65732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/tracker/tracker.module', 'tracker', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a373a22547261636b6572223b733a31313a226465736372697074696f6e223b733a34353a22456e61626c657320747261636b696e67206f6620726563656e7420636f6e74656e7420666f722075736572732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22747261636b65722e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/translation/tests/translation_test.module', 'translation_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a22436f6e74656e74205472616e736c6174696f6e2054657374223b733a31313a226465736372697074696f6e223b733a34393a22537570706f7274206d6f64756c6520666f722074686520636f6e74656e74207472616e736c6174696f6e2074657374732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/translation/translation.module', 'translation', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31393a22436f6e74656e74207472616e736c6174696f6e223b733a31313a226465736372697074696f6e223b733a35373a22416c6c6f777320636f6e74656e7420746f206265207472616e736c6174656420696e746f20646966666572656e74206c616e6775616765732e223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a226c6f63616c65223b7d733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31363a227472616e736c6174696f6e2e74657374223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/trigger/tests/trigger_test.module', 'trigger_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a22547269676765722054657374223b733a31313a226465736372697074696f6e223b733a33333a22537570706f7274206d6f64756c6520666f7220547269676765722074657374732e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/trigger/trigger.module', 'trigger', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a373a2254726967676572223b733a31313a226465736372697074696f6e223b733a39303a22456e61626c657320616374696f6e7320746f206265206669726564206f6e206365727461696e2073797374656d206576656e74732c2073756368206173207768656e206e657720636f6e74656e7420697320637265617465642e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31323a22747269676765722e74657374223b7d733a393a22636f6e666967757265223b733a32333a2261646d696e2f7374727563747572652f74726967676572223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/aaa_update_test.module', 'aaa_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22414141205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/bbb_update_test.module', 'bbb_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22424242205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/ccc_update_test.module', 'ccc_update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31353a22434343205570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/tests/update_test.module', 'update_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31313a225570646174652074657374223b733a31313a226465736372697074696f6e223b733a34313a22537570706f7274206d6f64756c6520666f7220757064617465206d6f64756c652074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/update/update.module', 'update', 'module', '', 1, 0, 7001, 0, 0x613a31333a7b733a343a226e616d65223b733a31343a22557064617465206d616e61676572223b733a31313a226465736372697074696f6e223b733a3130343a22436865636b7320666f7220617661696c61626c6520757064617465732c20616e642063616e207365637572656c7920696e7374616c6c206f7220757064617465206d6f64756c657320616e64207468656d65732076696120612077656220696e746572666163652e223b733a373a2276657273696f6e223b733a343a22372e3737223b733a373a227061636b616765223b733a343a22436f7265223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a313a7b693a303b733a31313a227570646174652e74657374223b7d733a393a22636f6e666967757265223b733a33303a2261646d696e2f7265706f7274732f757064617465732f73657474696e6773223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('modules/user/tests/user_flood_test.module', 'user_flood_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a33313a2255736572206d6f64756c6520666c6f6f6420636f6e74726f6c207465737473223b733a31313a226465736372697074696f6e223b733a34363a22537570706f7274206d6f64756c6520666f72207573657220666c6f6f6420636f6e74726f6c2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/user/tests/user_form_test.module', 'user_form_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32323a2255736572206d6f64756c6520666f726d207465737473223b733a31313a226465736372697074696f6e223b733a33373a22537570706f7274206d6f64756c6520666f72207573657220666f726d2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/user/tests/user_session_test.module', 'user_session_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32353a2255736572206d6f64756c652073657373696f6e207465737473223b733a31313a226465736372697074696f6e223b733a34303a22537570706f7274206d6f64756c6520666f7220757365722073657373696f6e2074657374696e672e223b733a373a227061636b616765223b733a373a2254657374696e67223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a363a2268696464656e223b623a313b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('modules/user/user.module', 'user', 'module', '', 1, 0, 7019, 0, 0x613a31353a7b733a343a226e616d65223b733a343a2255736572223b733a31313a226465736372697074696f6e223b733a34373a224d616e6167657320746865207573657220726567697374726174696f6e20616e64206c6f67696e2073797374656d2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a323a7b693a303b733a31313a22757365722e6d6f64756c65223b693a313b733a393a22757365722e74657374223b7d733a383a227265717569726564223b623a313b733a393a22636f6e666967757265223b733a31393a2261646d696e2f636f6e6669672f70656f706c65223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a383a22757365722e637373223b733a32313a226d6f64756c65732f757365722f757365722e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('profiles/standard/standard.profile', 'standard', 'module', '', 1, 0, 0, 1000, 0x613a31353a7b733a343a226e616d65223b733a383a225374616e64617264223b733a31313a226465736372697074696f6e223b733a35313a22496e7374616c6c207769746820636f6d6d6f6e6c792075736564206665617475726573207072652d636f6e666967757265642e223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a32313a7b693a303b733a353a22626c6f636b223b693a313b733a353a22636f6c6f72223b693a323b733a373a22636f6d6d656e74223b693a333b733a31303a22636f6e7465787475616c223b693a343b733a393a2264617368626f617264223b693a353b733a343a2268656c70223b693a363b733a353a22696d616765223b693a373b733a343a226c697374223b693a383b733a343a226d656e75223b693a393b733a363a226e756d626572223b693a31303b733a373a226f7074696f6e73223b693a31313b733a343a2270617468223b693a31323b733a383a227461786f6e6f6d79223b693a31333b733a353a2264626c6f67223b693a31343b733a363a22736561726368223b693a31353b733a383a2273686f7274637574223b693a31363b733a373a22746f6f6c626172223b693a31373b733a373a226f7665726c6179223b693a31383b733a383a226669656c645f7569223b693a31393b733a343a2266696c65223b693a32303b733a333a22726466223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a353a226d74696d65223b693a313630373030333434373b733a373a227061636b616765223b733a353a224f74686572223b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b733a363a2268696464656e223b623a313b733a383a227265717569726564223b623a313b733a31373a22646973747269627574696f6e5f6e616d65223b733a363a2244727570616c223b7d),
('sites/all/modules/contrib/composer_autoloader/composer_autoloader.module', 'composer_autoloader', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31393a22436f6d706f736572204175746f6c6f61646572223b733a31313a226465736372697074696f6e223b733a32393a224c6f61642074686520436f6d706f736572204175746f6c6f616465722e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a383a22436f6d706f736572223b733a373a2276657273696f6e223b733a373a22372e782d312e33223b733a373a2270726f6a656374223b733a31393a22636f6d706f7365725f6175746f6c6f61646572223b733a393a22646174657374616d70223b733a31303a2231353230373431383836223b733a353a226d74696d65223b693a313532303734313838363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/bulk_export/bulk_export.module', 'bulk_export', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31313a2242756c6b204578706f7274223b733a31313a226465736372697074696f6e223b733a36373a22506572666f726d732062756c6b206578706f7274696e67206f662064617461206f626a65637473206b6e6f776e2061626f7574206279204368616f7320746f6f6c732e223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/ctools.module', 'ctools', 'module', '', 1, 0, 7003, 0, 0x613a31323a7b733a343a226e616d65223b733a31313a224368616f7320746f6f6c73223b733a31313a226465736372697074696f6e223b733a34363a2241206c696272617279206f662068656c7066756c20746f6f6c73206279204d65726c696e206f66204368616f732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a353a2266696c6573223b613a31343a7b693a303b733a32303a22696e636c756465732f636f6e746578742e696e63223b693a313b733a32323a22696e636c756465732f6373732d63616368652e696e63223b693a323b733a32323a22696e636c756465732f6d6174682d657870722e696e63223b693a333b733a32313a22696e636c756465732f7374796c697a65722e696e63223b693a343b733a31383a2274657374732f636f6e746578742e74657374223b693a353b733a31343a2274657374732f6373732e74657374223b693a363b733a32303a2274657374732f6373735f63616368652e74657374223b693a373b733a32353a2274657374732f63746f6f6c732e706c7567696e732e74657374223b693a383b733a31373a2274657374732f63746f6f6c732e74657374223b693a393b733a32363a2274657374732f6d6174685f65787072657373696f6e2e74657374223b693a31303b733a33323a2274657374732f6d6174685f65787072657373696f6e5f737461636b2e74657374223b693a31313b733a32333a2274657374732f6f626a6563745f63616368652e74657374223b693a31323b733a32383a2274657374732f6f626a6563745f63616368655f756e69742e74657374223b693a31333b733a32323a2274657374732f706167655f746f6b656e732e74657374223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/ctools_access_ruleset/ctools_access_ruleset.module', 'ctools_access_ruleset', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31353a22437573746f6d2072756c6573657473223b733a31313a226465736372697074696f6e223b733a38313a2243726561746520637573746f6d2c206578706f727461626c652c207265757361626c65206163636573732072756c657365747320666f72206170706c69636174696f6e73206c696b652050616e656c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/ctools_ajax_sample/ctools_ajax_sample.module', 'ctools_ajax_sample', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a33333a224368616f7320546f6f6c73202843546f6f6c732920414a4158204578616d706c65223b733a31313a226465736372697074696f6e223b733a34313a2253686f777320686f7720746f207573652074686520706f776572206f66204368616f7320414a41582e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/ctools_custom_content/ctools_custom_content.module', 'ctools_custom_content', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a32303a22437573746f6d20636f6e74656e742070616e6573223b733a31313a226465736372697074696f6e223b733a37393a2243726561746520637573746f6d2c206578706f727461626c652c207265757361626c6520636f6e74656e742070616e657320666f72206170706c69636174696f6e73206c696b652050616e656c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/ctools_plugin_example/ctools_plugin_example.module', 'ctools_plugin_example', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a33353a224368616f7320546f6f6c73202843546f6f6c732920506c7567696e204578616d706c65223b733a31313a226465736372697074696f6e223b733a37353a2253686f777320686f7720616e2065787465726e616c206d6f64756c652063616e2070726f766964652063746f6f6c7320706c7567696e732028666f722050616e656c732c206574632e292e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a343a7b693a303b733a363a2263746f6f6c73223b693a313b733a363a2270616e656c73223b693a323b733a31323a22706167655f6d616e61676572223b693a333b733a31333a22616476616e6365645f68656c70223b7d733a343a22636f7265223b733a333a22372e78223b733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/page_manager/page_manager.module', 'page_manager', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31323a2250616765206d616e61676572223b733a31313a226465736372697074696f6e223b733a35343a2250726f7669646573206120554920616e642041504920746f206d616e6167652070616765732077697468696e2074686520736974652e223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a353a2266696c6573223b613a313a7b693a303b733a32313a2274657374732f686561645f6c696e6b732e74657374223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/stylizer/stylizer.module', 'stylizer', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a383a225374796c697a6572223b733a31313a226465736372697074696f6e223b733a35333a2243726561746520637573746f6d207374796c657320666f72206170706c69636174696f6e7320737563682061732050616e656c732e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a363a2263746f6f6c73223b693a313b733a353a22636f6c6f72223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/term_depth/term_depth.module', 'term_depth', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31373a225465726d20446570746820616363657373223b733a31313a226465736372697074696f6e223b733a34383a22436f6e74726f6c732061636365737320746f20636f6e746578742062617365642075706f6e207465726d206465707468223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/tests/ctools_export_test/ctools_export_test.module', 'ctools_export_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31383a2243546f6f6c73206578706f72742074657374223b733a31313a226465736372697074696f6e223b733a32353a2243546f6f6c73206578706f72742074657374206d6f64756c65223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a363a2268696464656e223b623a313b733a353a2266696c6573223b613a313a7b693a303b733a31383a2263746f6f6c735f6578706f72742e74657374223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/tests/ctools_plugin_test.module', 'ctools_plugin_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a32343a224368616f7320746f6f6c7320706c7567696e732074657374223b733a31313a226465736372697074696f6e223b733a34323a2250726f766964657320686f6f6b7320666f722074657374696e672063746f6f6c7320706c7567696e732e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/ctools/views_content/views_content.module', 'views_content', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31393a22566965777320636f6e74656e742070616e6573223b733a31313a226465736372697074696f6e223b733a3130343a22416c6c6f777320566965777320636f6e74656e7420746f206265207573656420696e2050616e656c732c2044617368626f61726420616e64206f74686572206d6f64756c657320776869636820757365207468652043546f6f6c7320436f6e74656e74204150492e223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a31323a22646570656e64656e63696573223b613a323a7b693a303b733a363a2263746f6f6c73223b693a313b733a353a227669657773223b7d733a343a22636f7265223b733a333a22372e78223b733a353a2266696c6573223b613a333a7b693a303b733a36313a22706c7567696e732f76696577732f76696577735f636f6e74656e745f706c7567696e5f646973706c61795f63746f6f6c735f636f6e746578742e696e63223b693a313b733a35373a22706c7567696e732f76696577732f76696577735f636f6e74656e745f706c7567696e5f646973706c61795f70616e656c5f70616e652e696e63223b693a323b733a35393a22706c7567696e732f76696577732f76696577735f636f6e74656e745f706c7567696e5f7374796c655f63746f6f6c735f636f6e746578742e696e63223b7d733a373a2276657273696f6e223b733a383a22372e782d312e3137223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231363033343930353531223b733a353a226d74696d65223b693a313630333439303535313b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/devel/devel.module', 'devel', 'module', '', 1, 1, 7008, 88, 0x613a31323a7b733a343a226e616d65223b733a353a22446576656c223b733a31313a226465736372697074696f6e223b733a35323a22566172696f757320626c6f636b732c2070616765732c20616e642066756e6374696f6e7320666f7220646576656c6f706572732e223b733a373a227061636b616765223b733a31313a22446576656c6f706d656e74223b733a343a22636f7265223b733a333a22372e78223b733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f646576656c6f706d656e742f646576656c223b733a343a2274616773223b613a313a7b693a303b733a393a22646576656c6f706572223b7d733a353a2266696c6573223b613a323a7b693a303b733a31303a22646576656c2e74657374223b693a313b733a31343a22646576656c2e6d61696c2e696e63223b7d733a353a226d74696d65223b693a313630383033313330343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a373a2276657273696f6e223b4e3b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/devel/devel_generate/devel_generate.module', 'devel_generate', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31343a22446576656c2067656e6572617465223b733a31313a226465736372697074696f6e223b733a34383a2247656e65726174652064756d6d792075736572732c206e6f6465732c20616e64207461786f6e6f6d79207465726d732e223b733a373a227061636b616765223b733a31313a22446576656c6f706d656e74223b733a343a22636f7265223b733a333a22372e78223b733a343a2274616773223b613a313a7b693a303b733a393a22646576656c6f706572223b7d733a393a22636f6e666967757265223b733a33333a2261646d696e2f636f6e6669672f646576656c6f706d656e742f67656e6572617465223b733a353a2266696c6573223b613a313a7b693a303b733a31393a22646576656c5f67656e65726174652e74657374223b7d733a353a226d74696d65223b693a313630383033313330343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a373a2276657273696f6e223b4e3b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/devel/devel_node_access.module', 'devel_node_access', 'module', '', 0, 0, -1, 0, 0x613a31323a7b733a343a226e616d65223b733a31373a22446576656c206e6f646520616363657373223b733a31313a226465736372697074696f6e223b733a36383a22446576656c6f70657220626c6f636b7320616e64207061676520696c6c757374726174696e672072656c6576616e74206e6f64655f616363657373207265636f7264732e223b733a373a227061636b616765223b733a31313a22446576656c6f706d656e74223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a343a226d656e75223b7d733a343a22636f7265223b733a333a22372e78223b733a393a22636f6e666967757265223b733a33303a2261646d696e2f636f6e6669672f646576656c6f706d656e742f646576656c223b733a343a2274616773223b613a313a7b693a303b733a393a22646576656c6f706572223b7d733a353a226d74696d65223b693a313630383033313330343b733a373a2276657273696f6e223b4e3b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/features/features.module', 'features', 'module', '', 1, 0, 7204, 20, 0x613a31343a7b733a343a226e616d65223b733a383a224665617475726573223b733a31313a226465736372697074696f6e223b733a33393a2250726f76696465732066656174757265206d616e6167656d656e7420666f722044727570616c2e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a383a224665617475726573223b733a353a2266696c6573223b613a313a7b693a303b733a31393a2274657374732f66656174757265732e74657374223b7d733a31373a22746573745f646570656e64656e63696573223b613a343a7b693a303b733a353a22696d616765223b693a313b733a393a227374726f6e6761726d223b693a323b733a383a227461786f6e6f6d79223b693a333b733a353a227669657773223b7d733a393a22636f6e666967757265223b733a33333a2261646d696e2f7374727563747572652f66656174757265732f73657474696e6773223b733a373a2276657273696f6e223b733a383a22372e782d322e3133223b733a373a2270726f6a656374223b733a383a226665617475726573223b733a393a22646174657374616d70223b733a31303a2231363035383534303536223b733a353a226d74696d65223b693a313630353835343035363b733a31323a22646570656e64656e63696573223b613a303a7b7d733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/features/tests/features_test/features_test.module', 'features_test', 'module', '', 0, 0, -1, 0, 0x613a31343a7b733a343a226e616d65223b733a31343a224665617475726573205465737473223b733a31313a226465736372697074696f6e223b733a33333a2254657374206d6f64756c6520666f722046656174757265732074657374696e672e223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a373a2254657374696e67223b733a333a22706870223b733a353a22352e322e30223b733a31323a22646570656e64656e63696573223b613a353a7b693a303b733a383a226665617475726573223b693a313b733a353a22696d616765223b693a323b733a393a227374726f6e6761726d223b693a333b733a383a227461786f6e6f6d79223b693a343b733a353a227669657773223b7d733a383a226665617475726573223b613a31303a7b733a363a2263746f6f6c73223b613a323a7b693a303b733a32313a227374726f6e6761726d3a7374726f6e6761726d3a31223b693a313b733a32333a2276696577733a76696577735f64656661756c743a332e30223b7d733a31323a2266656174757265735f617069223b613a313a7b693a303b733a353a226170693a32223b7d733a31303a226669656c645f62617365223b613a313a7b693a303b733a31393a226669656c645f66656174757265735f74657374223b7d733a31343a226669656c645f696e7374616e6365223b613a313a7b693a303b733a33383a226e6f64652d66656174757265735f746573742d6669656c645f66656174757265735f74657374223b7d733a363a2266696c746572223b613a313a7b693a303b733a31333a2266656174757265735f74657374223b7d733a353a22696d616765223b613a313a7b693a303b733a31333a2266656174757265735f74657374223b7d733a343a226e6f6465223b613a313a7b693a303b733a31333a2266656174757265735f74657374223b7d733a383a227461786f6e6f6d79223b613a313a7b693a303b733a32323a227461786f6e6f6d795f66656174757265735f74657374223b7d733a31353a22757365725f7065726d697373696f6e223b613a313a7b693a303b733a32383a226372656174652066656174757265735f7465737420636f6e74656e74223b7d733a31303a2276696577735f76696577223b613a313a7b693a303b733a31333a2266656174757265735f74657374223b7d7d733a363a2268696464656e223b733a313a2231223b733a373a2276657273696f6e223b733a383a22372e782d322e3133223b733a373a2270726f6a656374223b733a383a226665617475726573223b733a393a22646174657374616d70223b733a31303a2231363035383534303536223b733a353a226d74696d65223b693a313630353835343035363b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/views/tests/views_test.module', 'views_test', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31303a2256696577732054657374223b733a31313a226465736372697074696f6e223b733a32323a2254657374206d6f64756c6520666f722056696577732e223b733a373a227061636b616765223b733a353a225669657773223b733a343a22636f7265223b733a333a22372e78223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a227669657773223b7d733a363a2268696464656e223b623a313b733a373a2276657273696f6e223b733a383a22372e782d332e3234223b733a373a2270726f6a656374223b733a353a227669657773223b733a393a22646174657374616d70223b733a31303a2231353833363135373332223b733a353a226d74696d65223b693a313538333631353733323b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d);
INSERT INTO `jbqo_system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('sites/all/modules/contrib/views/views.module', 'views', 'module', '', 1, 0, 7302, 10, 0x613a31333a7b733a343a226e616d65223b733a353a225669657773223b733a31313a226465736372697074696f6e223b733a35353a2243726561746520637573746f6d697a6564206c6973747320616e6420717565726965732066726f6d20796f75722064617461626173652e223b733a373a227061636b616765223b733a353a225669657773223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31333a226373732f76696577732e637373223b733a34353a2273697465732f616c6c2f6d6f64756c65732f636f6e747269622f76696577732f6373732f76696577732e637373223b7d7d733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a363a2263746f6f6c73223b7d733a353a2266696c6573223b613a3331363a7b693a303b733a33313a2268616e646c6572732f76696577735f68616e646c65725f617265612e696e63223b693a313b733a34303a2268616e646c6572732f76696577735f68616e646c65725f617265615f6d657373616765732e696e63223b693a323b733a33383a2268616e646c6572732f76696577735f68616e646c65725f617265615f726573756c742e696e63223b693a333b733a33363a2268616e646c6572732f76696577735f68616e646c65725f617265615f746578742e696e63223b693a343b733a34333a2268616e646c6572732f76696577735f68616e646c65725f617265615f746578745f637573746f6d2e696e63223b693a353b733a33363a2268616e646c6572732f76696577735f68616e646c65725f617265615f766965772e696e63223b693a363b733a33353a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e742e696e63223b693a373b733a34303a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f646174652e696e63223b693a383b733a34333a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f666f726d756c612e696e63223b693a393b733a34373a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f6d616e795f746f5f6f6e652e696e63223b693a31303b733a34303a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f6e756c6c2e696e63223b693a31313b733a34333a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f6e756d657269632e696e63223b693a31323b733a34323a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f737472696e672e696e63223b693a31333b733a35323a2268616e646c6572732f76696577735f68616e646c65725f617267756d656e745f67726f75705f62795f6e756d657269632e696e63223b693a31343b733a33323a2268616e646c6572732f76696577735f68616e646c65725f6669656c642e696e63223b693a31353b733a34303a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f636f756e7465722e696e63223b693a31363b733a34303a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f626f6f6c65616e2e696e63223b693a31373b733a34393a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f636f6e7465787475616c5f6c696e6b732e696e63223b693a31383b733a34383a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f63746f6f6c735f64726f70646f776e2e696e63223b693a31393b733a33393a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f637573746f6d2e696e63223b693a32303b733a33373a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f646174652e696e63223b693a32313b733a33393a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f656e746974792e696e63223b693a32323b733a33383a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f6c696e6b732e696e63223b693a32333b733a33393a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f6d61726b75702e696e63223b693a32343b733a33373a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f6d6174682e696e63223b693a32353b733a34303a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f6e756d657269632e696e63223b693a32363b733a34373a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f70726572656e6465725f6c6973742e696e63223b693a32373b733a34363a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f74696d655f696e74657276616c2e696e63223b693a32383b733a34333a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f73657269616c697a65642e696e63223b693a32393b733a34353a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f6d616368696e655f6e616d652e696e63223b693a33303b733a33363a2268616e646c6572732f76696577735f68616e646c65725f6669656c645f75726c2e696e63223b693a33313b733a33333a2268616e646c6572732f76696577735f68616e646c65725f66696c7465722e696e63223b693a33323b733a35303a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f626f6f6c65616e5f6f70657261746f722e696e63223b693a33333b733a35373a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f626f6f6c65616e5f6f70657261746f725f737472696e672e696e63223b693a33343b733a34313a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f636f6d62696e652e696e63223b693a33353b733a33383a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f646174652e696e63223b693a33363b733a34323a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f657175616c6974792e696e63223b693a33373b733a34373a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f656e746974795f62756e646c652e696e63223b693a33383b733a35303a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f67726f75705f62795f6e756d657269632e696e63223b693a33393b733a34353a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f696e5f6f70657261746f722e696e63223b693a34303b733a34353a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f6d616e795f746f5f6f6e652e696e63223b693a34313b733a34313a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f6e756d657269632e696e63223b693a34323b733a34303a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f737472696e672e696e63223b693a34333b733a34383a2268616e646c6572732f76696577735f68616e646c65725f66696c7465725f6669656c64735f636f6d706172652e696e63223b693a34343b733a33393a2268616e646c6572732f76696577735f68616e646c65725f72656c6174696f6e736869702e696e63223b693a34353b733a35333a2268616e646c6572732f76696577735f68616e646c65725f72656c6174696f6e736869705f67726f7570776973655f6d61782e696e63223b693a34363b733a33313a2268616e646c6572732f76696577735f68616e646c65725f736f72742e696e63223b693a34373b733a33363a2268616e646c6572732f76696577735f68616e646c65725f736f72745f646174652e696e63223b693a34383b733a33393a2268616e646c6572732f76696577735f68616e646c65725f736f72745f666f726d756c612e696e63223b693a34393b733a34383a2268616e646c6572732f76696577735f68616e646c65725f736f72745f67726f75705f62795f6e756d657269632e696e63223b693a35303b733a34363a2268616e646c6572732f76696577735f68616e646c65725f736f72745f6d656e755f6869657261726368792e696e63223b693a35313b733a33383a2268616e646c6572732f76696577735f68616e646c65725f736f72745f72616e646f6d2e696e63223b693a35323b733a31373a22696e636c756465732f626173652e696e63223b693a35333b733a32313a22696e636c756465732f68616e646c6572732e696e63223b693a35343b733a32303a22696e636c756465732f706c7567696e732e696e63223b693a35353b733a31373a22696e636c756465732f766965772e696e63223b693a35363b733a36303a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f617267756d656e745f61676772656761746f725f6669642e696e63223b693a35373b733a36303a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f617267756d656e745f61676772656761746f725f6969642e696e63223b693a35383b733a36393a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f617267756d656e745f61676772656761746f725f63617465676f72795f6369642e696e63223b693a35393b733a36343a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f6669656c645f61676772656761746f725f7469746c655f6c696e6b2e696e63223b693a36303b733a36323a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f6669656c645f61676772656761746f725f63617465676f72792e696e63223b693a36313b733a37303a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f6669656c645f61676772656761746f725f6974656d5f6465736372697074696f6e2e696e63223b693a36323b733a35373a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f6669656c645f61676772656761746f725f7873732e696e63223b693a36333b733a36373a226d6f64756c65732f61676772656761746f722f76696577735f68616e646c65725f66696c7465725f61676772656761746f725f63617465676f72795f6369642e696e63223b693a36343b733a35343a226d6f64756c65732f61676772656761746f722f76696577735f706c7567696e5f726f775f61676772656761746f725f7273732e696e63223b693a36353b733a35363a226d6f64756c65732f626f6f6b2f76696577735f706c7567696e5f617267756d656e745f64656661756c745f626f6f6b5f726f6f742e696e63223b693a36363b733a35393a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f617267756d656e745f636f6d6d656e745f757365725f7569642e696e63223b693a36373b733a34373a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e742e696e63223b693a36383b733a35333a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f64657074682e696e63223b693a36393b733a35323a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f6c696e6b2e696e63223b693a37303b733a36303a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f6c696e6b5f617070726f76652e696e63223b693a37313b733a35393a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f6c696e6b5f64656c6574652e696e63223b693a37323b733a35373a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f6c696e6b5f656469742e696e63223b693a37333b733a35383a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f6c696e6b5f7265706c792e696e63223b693a37343b733a35373a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f6e6f64655f6c696e6b2e696e63223b693a37353b733a35363a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f636f6d6d656e745f757365726e616d652e696e63223b693a37363b733a36313a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f6e63735f6c6173745f636f6d6d656e745f6e616d652e696e63223b693a37373b733a35363a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f6e63735f6c6173745f757064617465642e696e63223b693a37383b733a35323a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f6e6f64655f636f6d6d656e742e696e63223b693a37393b733a35373a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f6e6f64655f6e65775f636f6d6d656e74732e696e63223b693a38303b733a36323a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f6669656c645f6c6173745f636f6d6d656e745f74696d657374616d702e696e63223b693a38313b733a35373a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f66696c7465725f636f6d6d656e745f757365725f7569642e696e63223b693a38323b733a35373a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f66696c7465725f6e63735f6c6173745f757064617465642e696e63223b693a38333b733a35333a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f66696c7465725f6e6f64655f636f6d6d656e742e696e63223b693a38343b733a35333a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f736f72745f636f6d6d656e745f7468726561642e696e63223b693a38353b733a36303a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f736f72745f6e63735f6c6173745f636f6d6d656e745f6e616d652e696e63223b693a38363b733a35353a226d6f64756c65732f636f6d6d656e742f76696577735f68616e646c65725f736f72745f6e63735f6c6173745f757064617465642e696e63223b693a38373b733a34383a226d6f64756c65732f636f6d6d656e742f76696577735f706c7567696e5f726f775f636f6d6d656e745f7273732e696e63223b693a38383b733a34393a226d6f64756c65732f636f6d6d656e742f76696577735f706c7567696e5f726f775f636f6d6d656e745f766965772e696e63223b693a38393b733a35323a226d6f64756c65732f636f6e746163742f76696577735f68616e646c65725f6669656c645f636f6e746163745f6c696e6b2e696e63223b693a39303b733a34333a226d6f64756c65732f6669656c642f76696577735f68616e646c65725f6669656c645f6669656c642e696e63223b693a39313b733a35393a226d6f64756c65732f6669656c642f76696577735f68616e646c65725f72656c6174696f6e736869705f656e746974795f726576657273652e696e63223b693a39323b733a35313a226d6f64756c65732f6669656c642f76696577735f68616e646c65725f617267756d656e745f6669656c645f6c6973742e696e63223b693a39333b733a35373a226d6f64756c65732f6669656c642f76696577735f68616e646c65725f66696c7465725f6669656c645f6c6973745f626f6f6c65616e2e696e63223b693a39343b733a35383a226d6f64756c65732f6669656c642f76696577735f68616e646c65725f617267756d656e745f6669656c645f6c6973745f737472696e672e696e63223b693a39353b733a34393a226d6f64756c65732f6669656c642f76696577735f68616e646c65725f66696c7465725f6669656c645f6c6973742e696e63223b693a39363b733a35373a226d6f64756c65732f66696c7465722f76696577735f68616e646c65725f6669656c645f66696c7465725f666f726d61745f6e616d652e696e63223b693a39373b733a35323a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f6669656c645f6e6f64655f6c616e67756167652e696e63223b693a39383b733a35333a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f66696c7465725f6e6f64655f6c616e67756167652e696e63223b693a39393b733a35343a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f617267756d656e745f6c6f63616c655f67726f75702e696e63223b693a3130303b733a35373a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f617267756d656e745f6c6f63616c655f6c616e67756167652e696e63223b693a3130313b733a35313a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f6669656c645f6c6f63616c655f67726f75702e696e63223b693a3130323b733a35343a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f6669656c645f6c6f63616c655f6c616e67756167652e696e63223b693a3130333b733a35353a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f6669656c645f6c6f63616c655f6c696e6b5f656469742e696e63223b693a3130343b733a35323a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f66696c7465725f6c6f63616c655f67726f75702e696e63223b693a3130353b733a35353a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f66696c7465725f6c6f63616c655f6c616e67756167652e696e63223b693a3130363b733a35343a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f66696c7465725f6c6f63616c655f76657273696f6e2e696e63223b693a3130373b733a35313a226d6f64756c65732f6c6f63616c652f76696577735f68616e646c65725f736f72745f6e6f64655f6c616e67756167652e696e63223b693a3130383b733a35333a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f617267756d656e745f64617465735f766172696f75732e696e63223b693a3130393b733a35333a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f617267756d656e745f6e6f64655f6c616e67756167652e696e63223b693a3131303b733a34383a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f617267756d656e745f6e6f64655f6e69642e696e63223b693a3131313b733a34393a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f617267756d656e745f6e6f64655f747970652e696e63223b693a3131323b733a34383a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f617267756d656e745f6e6f64655f7669642e696e63223b693a3131333b733a35373a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f617267756d656e745f6e6f64655f7569645f7265766973696f6e2e696e63223b693a3131343b733a35393a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f686973746f72795f757365725f74696d657374616d702e696e63223b693a3131353b733a34313a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64652e696e63223b693a3131363b733a34363a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f6c696e6b2e696e63223b693a3131373b733a35333a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f6c696e6b5f64656c6574652e696e63223b693a3131383b733a35313a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f6c696e6b5f656469742e696e63223b693a3131393b733a35303a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f7265766973696f6e2e696e63223b693a3132303b733a35353a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f7265766973696f6e5f6c696e6b2e696e63223b693a3132313b733a36323a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f7265766973696f6e5f6c696e6b5f64656c6574652e696e63223b693a3132323b733a36323a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f7265766973696f6e5f6c696e6b5f7265766572742e696e63223b693a3132333b733a34363a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f706174682e696e63223b693a3132343b733a34363a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f747970652e696e63223b693a3132353b733a35353a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f6669656c645f6e6f64655f76657273696f6e5f636f756e742e696e63223b693a3132363b733a36303a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f66696c7465725f686973746f72795f757365725f74696d657374616d702e696e63223b693a3132373b733a34393a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f66696c7465725f6e6f64655f6163636573732e696e63223b693a3132383b733a34393a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f66696c7465725f6e6f64655f7374617475732e696e63223b693a3132393b733a34373a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f66696c7465725f6e6f64655f747970652e696e63223b693a3133303b733a35353a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f66696c7465725f6e6f64655f7569645f7265766973696f6e2e696e63223b693a3133313b733a35363a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f66696c7465725f6e6f64655f76657273696f6e5f636f756e742e696e63223b693a3133323b733a35343a226d6f64756c65732f6e6f64652f76696577735f68616e646c65725f736f72745f6e6f64655f76657273696f6e5f636f756e742e696e63223b693a3133333b733a35313a226d6f64756c65732f6e6f64652f76696577735f706c7567696e5f617267756d656e745f64656661756c745f6e6f64652e696e63223b693a3133343b733a35323a226d6f64756c65732f6e6f64652f76696577735f706c7567696e5f617267756d656e745f76616c69646174655f6e6f64652e696e63223b693a3133353b733a34323a226d6f64756c65732f6e6f64652f76696577735f706c7567696e5f726f775f6e6f64655f7273732e696e63223b693a3133363b733a34333a226d6f64756c65732f6e6f64652f76696577735f706c7567696e5f726f775f6e6f64655f766965772e696e63223b693a3133373b733a35323a226d6f64756c65732f70726f66696c652f76696577735f68616e646c65725f6669656c645f70726f66696c655f646174652e696e63223b693a3133383b733a35323a226d6f64756c65732f70726f66696c652f76696577735f68616e646c65725f6669656c645f70726f66696c655f6c6973742e696e63223b693a3133393b733a35383a226d6f64756c65732f70726f66696c652f76696577735f68616e646c65725f66696c7465725f70726f66696c655f73656c656374696f6e2e696e63223b693a3134303b733a34383a226d6f64756c65732f7365617263682f76696577735f68616e646c65725f617267756d656e745f7365617263682e696e63223b693a3134313b733a35313a226d6f64756c65732f7365617263682f76696577735f68616e646c65725f6669656c645f7365617263685f73636f72652e696e63223b693a3134323b733a34363a226d6f64756c65732f7365617263682f76696577735f68616e646c65725f66696c7465725f7365617263682e696e63223b693a3134333b733a35303a226d6f64756c65732f7365617263682f76696577735f68616e646c65725f736f72745f7365617263685f73636f72652e696e63223b693a3134343b733a34373a226d6f64756c65732f7365617263682f76696577735f706c7567696e5f726f775f7365617263685f766965772e696e63223b693a3134353b733a35373a226d6f64756c65732f737461746973746963732f76696577735f68616e646c65725f6669656c645f6163636573736c6f675f706174682e696e63223b693a3134363b733a36353a226d6f64756c65732f737461746973746963732f76696577735f68616e646c65725f6669656c645f6e6f64655f636f756e7465725f74696d657374616d702e696e63223b693a3134373b733a36313a226d6f64756c65732f737461746973746963732f76696577735f68616e646c65725f6669656c645f737461746973746963735f6e756d657269632e696e63223b693a3134383b733a35303a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f617267756d656e745f66696c655f6669642e696e63223b693a3134393b733a34333a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f6669656c645f66696c652e696e63223b693a3135303b733a35333a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f6669656c645f66696c655f657874656e73696f6e2e696e63223b693a3135313b733a35323a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f6669656c645f66696c655f66696c656d696d652e696e63223b693a3135323b733a34373a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f6669656c645f66696c655f7572692e696e63223b693a3135333b733a35303a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f6669656c645f66696c655f7374617475732e696e63223b693a3135343b733a35313a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f66696c7465725f66696c655f7374617475732e696e63223b693a3135353b733a35323a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f7461786f6e6f6d792e696e63223b693a3135363b733a35373a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f7465726d5f6e6f64655f7469642e696e63223b693a3135373b733a36333a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f7465726d5f6e6f64655f7469645f64657074682e696e63223b693a3135383b733a36383a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f7465726d5f6e6f64655f7469645f64657074685f6a6f696e2e696e63223b693a3135393b733a37323a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f7465726d5f6e6f64655f7469645f64657074685f6d6f6469666965722e696e63223b693a3136303b733a35383a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f766f636162756c6172795f7669642e696e63223b693a3136313b733a36373a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f617267756d656e745f766f636162756c6172795f6d616368696e655f6e616d652e696e63223b693a3136323b733a34393a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f6669656c645f7461786f6e6f6d792e696e63223b693a3136333b733a35343a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f6669656c645f7465726d5f6e6f64655f7469642e696e63223b693a3136343b733a35353a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f6669656c645f7465726d5f6c696e6b5f656469742e696e63223b693a3136353b733a35353a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f66696c7465725f7465726d5f6e6f64655f7469642e696e63223b693a3136363b733a36313a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f66696c7465725f7465726d5f6e6f64655f7469645f64657074682e696e63223b693a3136373b733a36363a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f66696c7465725f7465726d5f6e6f64655f7469645f64657074685f6a6f696e2e696e63223b693a3136383b733a35363a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f66696c7465725f766f636162756c6172795f7669642e696e63223b693a3136393b733a36353a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f66696c7465725f766f636162756c6172795f6d616368696e655f6e616d652e696e63223b693a3137303b733a36323a226d6f64756c65732f7461786f6e6f6d792f76696577735f68616e646c65725f72656c6174696f6e736869705f6e6f64655f7465726d5f646174612e696e63223b693a3137313b733a36353a226d6f64756c65732f7461786f6e6f6d792f76696577735f706c7567696e5f617267756d656e745f76616c69646174655f7461786f6e6f6d795f7465726d2e696e63223b693a3137323b733a36333a226d6f64756c65732f7461786f6e6f6d792f76696577735f706c7567696e5f617267756d656e745f64656661756c745f7461786f6e6f6d795f7469642e696e63223b693a3137333b733a36373a226d6f64756c65732f747261636b65722f76696577735f68616e646c65725f617267756d656e745f747261636b65725f636f6d6d656e745f757365725f7569642e696e63223b693a3137343b733a36353a226d6f64756c65732f747261636b65722f76696577735f68616e646c65725f66696c7465725f747261636b65725f636f6d6d656e745f757365725f7569642e696e63223b693a3137353b733a36353a226d6f64756c65732f747261636b65722f76696577735f68616e646c65725f66696c7465725f747261636b65725f626f6f6c65616e5f6f70657261746f722e696e63223b693a3137363b733a35313a226d6f64756c65732f73797374656d2f76696577735f68616e646c65725f66696c7465725f73797374656d5f747970652e696e63223b693a3137373b733a35363a226d6f64756c65732f7472616e736c6174696f6e2f76696577735f68616e646c65725f617267756d656e745f6e6f64655f746e69642e696e63223b693a3137383b733a36333a226d6f64756c65732f7472616e736c6174696f6e2f76696577735f68616e646c65725f6669656c645f6e6f64655f6c696e6b5f7472616e736c6174652e696e63223b693a3137393b733a36353a226d6f64756c65732f7472616e736c6174696f6e2f76696577735f68616e646c65725f6669656c645f6e6f64655f7472616e736c6174696f6e5f6c696e6b2e696e63223b693a3138303b733a35343a226d6f64756c65732f7472616e736c6174696f6e2f76696577735f68616e646c65725f66696c7465725f6e6f64655f746e69642e696e63223b693a3138313b733a36303a226d6f64756c65732f7472616e736c6174696f6e2f76696577735f68616e646c65725f66696c7465725f6e6f64655f746e69645f6368696c642e696e63223b693a3138323b733a36323a226d6f64756c65732f7472616e736c6174696f6e2f76696577735f68616e646c65725f72656c6174696f6e736869705f7472616e736c6174696f6e2e696e63223b693a3138333b733a34383a226d6f64756c65732f757365722f76696577735f68616e646c65725f617267756d656e745f757365725f7569642e696e63223b693a3138343b733a35353a226d6f64756c65732f757365722f76696577735f68616e646c65725f617267756d656e745f75736572735f726f6c65735f7269642e696e63223b693a3138353b733a34313a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365722e696e63223b693a3138363b733a35303a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6c616e67756167652e696e63223b693a3138373b733a34363a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6c696e6b2e696e63223b693a3138383b733a35333a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6c696e6b5f63616e63656c2e696e63223b693a3138393b733a35313a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6c696e6b5f656469742e696e63223b693a3139303b733a34363a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6d61696c2e696e63223b693a3139313b733a34363a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6e616d652e696e63223b693a3139323b733a35333a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f7065726d697373696f6e732e696e63223b693a3139333b733a34393a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f706963747572652e696e63223b693a3139343b733a34373a226d6f64756c65732f757365722f76696577735f68616e646c65725f6669656c645f757365725f726f6c65732e696e63223b693a3139353b733a35303a226d6f64756c65732f757365722f76696577735f68616e646c65725f66696c7465725f757365725f63757272656e742e696e63223b693a3139363b733a34373a226d6f64756c65732f757365722f76696577735f68616e646c65725f66696c7465725f757365725f6e616d652e696e63223b693a3139373b733a35343a226d6f64756c65732f757365722f76696577735f68616e646c65725f66696c7465725f757365725f7065726d697373696f6e732e696e63223b693a3139383b733a34383a226d6f64756c65732f757365722f76696577735f68616e646c65725f66696c7465725f757365725f726f6c65732e696e63223b693a3139393b733a35393a226d6f64756c65732f757365722f76696577735f706c7567696e5f617267756d656e745f64656661756c745f63757272656e745f757365722e696e63223b693a3230303b733a35313a226d6f64756c65732f757365722f76696577735f706c7567696e5f617267756d656e745f64656661756c745f757365722e696e63223b693a3230313b733a35323a226d6f64756c65732f757365722f76696577735f706c7567696e5f617267756d656e745f76616c69646174655f757365722e696e63223b693a3230323b733a34333a226d6f64756c65732f757365722f76696577735f706c7567696e5f726f775f757365725f766965772e696e63223b693a3230333b733a33313a22706c7567696e732f76696577735f706c7567696e5f6163636573732e696e63223b693a3230343b733a33363a22706c7567696e732f76696577735f706c7567696e5f6163636573735f6e6f6e652e696e63223b693a3230353b733a33363a22706c7567696e732f76696577735f706c7567696e5f6163636573735f7065726d2e696e63223b693a3230363b733a33363a22706c7567696e732f76696577735f706c7567696e5f6163636573735f726f6c652e696e63223b693a3230373b733a34313a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f64656661756c742e696e63223b693a3230383b733a34353a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f64656661756c745f7068702e696e63223b693a3230393b733a34373a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f64656661756c745f66697865642e696e63223b693a3231303b733a34353a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f64656661756c745f7261772e696e63223b693a3231313b733a34323a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f76616c69646174652e696e63223b693a3231323b733a35303a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f76616c69646174655f6e756d657269632e696e63223b693a3231333b733a34363a22706c7567696e732f76696577735f706c7567696e5f617267756d656e745f76616c69646174655f7068702e696e63223b693a3231343b733a33303a22706c7567696e732f76696577735f706c7567696e5f63616368652e696e63223b693a3231353b733a33353a22706c7567696e732f76696577735f706c7567696e5f63616368655f6e6f6e652e696e63223b693a3231363b733a33353a22706c7567696e732f76696577735f706c7567696e5f63616368655f74696d652e696e63223b693a3231373b733a33323a22706c7567696e732f76696577735f706c7567696e5f646973706c61792e696e63223b693a3231383b733a34333a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f6174746163686d656e742e696e63223b693a3231393b733a33383a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f626c6f636b2e696e63223b693a3232303b733a34303a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f64656661756c742e696e63223b693a3232313b733a33383a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f656d6265642e696e63223b693a3232323b733a34313a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f657874656e6465722e696e63223b693a3232333b733a33373a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f666565642e696e63223b693a3232343b733a33373a22706c7567696e732f76696577735f706c7567696e5f646973706c61795f706167652e696e63223b693a3232353b733a34333a22706c7567696e732f76696577735f706c7567696e5f6578706f7365645f666f726d5f62617369632e696e63223b693a3232363b733a33373a22706c7567696e732f76696577735f706c7567696e5f6578706f7365645f666f726d2e696e63223b693a3232373b733a35323a22706c7567696e732f76696577735f706c7567696e5f6578706f7365645f666f726d5f696e7075745f72657175697265642e696e63223b693a3232383b733a34323a22706c7567696e732f76696577735f706c7567696e5f6c6f63616c697a6174696f6e5f636f72652e696e63223b693a3232393b733a33373a22706c7567696e732f76696577735f706c7567696e5f6c6f63616c697a6174696f6e2e696e63223b693a3233303b733a34323a22706c7567696e732f76696577735f706c7567696e5f6c6f63616c697a6174696f6e5f6e6f6e652e696e63223b693a3233313b733a33303a22706c7567696e732f76696577735f706c7567696e5f70616765722e696e63223b693a3233323b733a33353a22706c7567696e732f76696577735f706c7567696e5f70616765725f66756c6c2e696e63223b693a3233333b733a33353a22706c7567696e732f76696577735f706c7567696e5f70616765725f6d696e692e696e63223b693a3233343b733a33353a22706c7567696e732f76696577735f706c7567696e5f70616765725f6e6f6e652e696e63223b693a3233353b733a33353a22706c7567696e732f76696577735f706c7567696e5f70616765725f736f6d652e696e63223b693a3233363b733a33303a22706c7567696e732f76696577735f706c7567696e5f71756572792e696e63223b693a3233373b733a33383a22706c7567696e732f76696577735f706c7567696e5f71756572795f64656661756c742e696e63223b693a3233383b733a32383a22706c7567696e732f76696577735f706c7567696e5f726f772e696e63223b693a3233393b733a33353a22706c7567696e732f76696577735f706c7567696e5f726f775f6669656c64732e696e63223b693a3234303b733a33393a22706c7567696e732f76696577735f706c7567696e5f726f775f7273735f6669656c64732e696e63223b693a3234313b733a33303a22706c7567696e732f76696577735f706c7567696e5f7374796c652e696e63223b693a3234323b733a33383a22706c7567696e732f76696577735f706c7567696e5f7374796c655f64656661756c742e696e63223b693a3234333b733a33353a22706c7567696e732f76696577735f706c7567696e5f7374796c655f677269642e696e63223b693a3234343b733a33353a22706c7567696e732f76696577735f706c7567696e5f7374796c655f6c6973742e696e63223b693a3234353b733a34303a22706c7567696e732f76696577735f706c7567696e5f7374796c655f6a756d705f6d656e752e696e63223b693a3234363b733a33383a22706c7567696e732f76696577735f706c7567696e5f7374796c655f6d617070696e672e696e63223b693a3234373b733a33343a22706c7567696e732f76696577735f706c7567696e5f7374796c655f7273732e696e63223b693a3234383b733a33383a22706c7567696e732f76696577735f706c7567696e5f7374796c655f73756d6d6172792e696e63223b693a3234393b733a34383a22706c7567696e732f76696577735f706c7567696e5f7374796c655f73756d6d6172795f6a756d705f6d656e752e696e63223b693a3235303b733a35303a22706c7567696e732f76696577735f706c7567696e5f7374796c655f73756d6d6172795f756e666f726d61747465642e696e63223b693a3235313b733a33363a22706c7567696e732f76696577735f706c7567696e5f7374796c655f7461626c652e696e63223b693a3235323b733a33343a2274657374732f68616e646c6572732f76696577735f68616e646c6572732e74657374223b693a3235333b733a34333a2274657374732f68616e646c6572732f76696577735f68616e646c65725f617265615f746578742e74657374223b693a3235343b733a34373a2274657374732f68616e646c6572732f76696577735f68616e646c65725f617267756d656e745f6e756c6c2e74657374223b693a3235353b733a33393a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c642e74657374223b693a3235363b733a34373a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f626f6f6c65616e2e74657374223b693a3235373b733a34363a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f637573746f6d2e74657374223b693a3235383b733a34373a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f636f756e7465722e74657374223b693a3235393b733a34343a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f646174652e74657374223b693a3236303b733a35343a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f66696c655f657874656e73696f6e2e74657374223b693a3236313b733a34393a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f66696c655f73697a652e74657374223b693a3236323b733a34343a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f6d6174682e74657374223b693a3236333b733a34333a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f75726c2e74657374223b693a3236343b733a34333a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6669656c645f7873732e74657374223b693a3236353b733a34383a2274657374732f68616e646c6572732f76696577735f68616e646c65725f66696c7465725f636f6d62696e652e74657374223b693a3236363b733a34353a2274657374732f68616e646c6572732f76696577735f68616e646c65725f66696c7465725f646174652e74657374223b693a3236373b733a34393a2274657374732f68616e646c6572732f76696577735f68616e646c65725f66696c7465725f657175616c6974792e74657374223b693a3236383b733a35323a2274657374732f68616e646c6572732f76696577735f68616e646c65725f66696c7465725f696e5f6f70657261746f722e74657374223b693a3236393b733a34383a2274657374732f68616e646c6572732f76696577735f68616e646c65725f66696c7465725f6e756d657269632e74657374223b693a3237303b733a34373a2274657374732f68616e646c6572732f76696577735f68616e646c65725f66696c7465725f737472696e672e74657374223b693a3237313b733a34333a2274657374732f68616e646c6572732f76696577735f68616e646c65725f6d616e79746f6f6e652e74657374223b693a3237323b733a34353a2274657374732f68616e646c6572732f76696577735f68616e646c65725f736f72745f72616e646f6d2e74657374223b693a3237333b733a34333a2274657374732f68616e646c6572732f76696577735f68616e646c65725f736f72745f646174652e74657374223b693a3237343b733a33383a2274657374732f68616e646c6572732f76696577735f68616e646c65725f736f72742e74657374223b693a3237353b733a34363a2274657374732f746573745f68616e646c6572732f76696577735f746573745f617265615f6163636573732e696e63223b693a3237363b733a36303a2274657374732f746573745f706c7567696e732f76696577735f746573745f706c7567696e5f6163636573735f746573745f64796e616d69632e696e63223b693a3237373b733a35393a2274657374732f746573745f706c7567696e732f76696577735f746573745f706c7567696e5f6163636573735f746573745f7374617469632e696e63223b693a3237383b733a35393a2274657374732f746573745f706c7567696e732f76696577735f746573745f706c7567696e5f7374796c655f746573745f6d617070696e672e696e63223b693a3237393b733a33393a2274657374732f706c7567696e732f76696577735f706c7567696e5f646973706c61792e74657374223b693a3238303b733a34363a2274657374732f7374796c65732f76696577735f706c7567696e5f7374796c655f6a756d705f6d656e752e74657374223b693a3238313b733a33363a2274657374732f7374796c65732f76696577735f706c7567696e5f7374796c652e74657374223b693a3238323b733a34313a2274657374732f7374796c65732f76696577735f706c7567696e5f7374796c655f626173652e74657374223b693a3238333b733a34343a2274657374732f7374796c65732f76696577735f706c7567696e5f7374796c655f6d617070696e672e74657374223b693a3238343b733a34383a2274657374732f7374796c65732f76696577735f706c7567696e5f7374796c655f756e666f726d61747465642e74657374223b693a3238353b733a32333a2274657374732f76696577735f6163636573732e74657374223b693a3238363b733a32343a2274657374732f76696577735f616e616c797a652e74657374223b693a3238373b733a32323a2274657374732f76696577735f62617369632e74657374223b693a3238383b733a32313a2274657374732f76696577735f616a61782e74657374223b693a3238393b733a33333a2274657374732f76696577735f617267756d656e745f64656661756c742e74657374223b693a3239303b733a33353a2274657374732f76696577735f617267756d656e745f76616c696461746f722e74657374223b693a3239313b733a32393a2274657374732f76696577735f6578706f7365645f666f726d2e74657374223b693a3239323b733a33313a2274657374732f6669656c642f76696577735f6669656c646170692e74657374223b693a3239333b733a32353a2274657374732f76696577735f676c6f73736172792e74657374223b693a3239343b733a32343a2274657374732f76696577735f67726f757062792e74657374223b693a3239353b733a33313a2274657374732f76696577735f68616e646c65725f66696c7465722e74657374223b693a3239363b733a32353a2274657374732f76696577735f68616e646c6572732e74657374223b693a3239373b733a32333a2274657374732f76696577735f6d6f64756c652e74657374223b693a3239383b733a32323a2274657374732f76696577735f70616765722e74657374223b693a3239393b733a34303a2274657374732f76696577735f706c7567696e5f6c6f63616c697a6174696f6e5f746573742e696e63223b693a3330303b733a32393a2274657374732f76696577735f7472616e736c617461626c652e74657374223b693a3330313b733a32323a2274657374732f76696577735f71756572792e74657374223b693a3330323b733a32343a2274657374732f76696577735f757067726164652e74657374223b693a3330333b733a33343a2274657374732f76696577735f746573742e76696577735f64656661756c742e696e63223b693a3330343b733a35383a2274657374732f636f6d6d656e742f76696577735f68616e646c65725f617267756d656e745f636f6d6d656e745f757365725f7569642e74657374223b693a3330353b733a35363a2274657374732f636f6d6d656e742f76696577735f68616e646c65725f66696c7465725f636f6d6d656e745f757365725f7569642e74657374223b693a3330363b733a34353a2274657374732f6e6f64652f76696577735f6e6f64655f7265766973696f6e5f72656c6174696f6e732e74657374223b693a3330373b733a36313a2274657374732f7461786f6e6f6d792f76696577735f68616e646c65725f72656c6174696f6e736869705f6e6f64655f7465726d5f646174612e74657374223b693a3330383b733a34353a2274657374732f757365722f76696577735f68616e646c65725f6669656c645f757365725f6e616d652e74657374223b693a3330393b733a34333a2274657374732f757365722f76696577735f757365725f617267756d656e745f64656661756c742e74657374223b693a3331303b733a34343a2274657374732f757365722f76696577735f757365725f617267756d656e745f76616c69646174652e74657374223b693a3331313b733a32363a2274657374732f757365722f76696577735f757365722e74657374223b693a3331323b733a32323a2274657374732f76696577735f63616368652e74657374223b693a3331333b733a32323a2274657374732f76696577735f636c6f6e652e74657374223b693a3331343b733a32313a2274657374732f76696577735f766965772e74657374223b693a3331353b733a31393a2274657374732f76696577735f75692e74657374223b7d733a373a2276657273696f6e223b733a383a22372e782d332e3234223b733a373a2270726f6a656374223b733a353a227669657773223b733a393a22646174657374616d70223b733a31303a2231353833363135373332223b733a353a226d74696d65223b693a313538333631353733323b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/contrib/views/views_ui.module', 'views_ui', 'module', '', 1, 0, 0, 0, 0x613a31343a7b733a343a226e616d65223b733a383a225669657773205549223b733a31313a226465736372697074696f6e223b733a39333a2241646d696e69737472617469766520696e7465726661636520746f2076696577732e20576974686f75742074686973206d6f64756c652c20796f752063616e6e6f7420637265617465206f72206564697420796f75722076696577732e223b733a373a227061636b616765223b733a353a225669657773223b733a343a22636f7265223b733a333a22372e78223b733a393a22636f6e666967757265223b733a32313a2261646d696e2f7374727563747572652f7669657773223b733a31323a22646570656e64656e63696573223b613a313a7b693a303b733a353a227669657773223b7d733a33343a22232040636f64696e675374616e646172647349676e6f72654c696e650a66696c6573223b613a313a7b693a303b733a31353a2276696577735f75692e6d6f64756c65223b7d733a353a2266696c6573223b613a313a7b693a303b733a35373a22706c7567696e732f76696577735f77697a6172642f76696577735f75695f626173655f76696577735f77697a6172642e636c6173732e706870223b7d733a373a2276657273696f6e223b733a383a22372e782d332e3234223b733a373a2270726f6a656374223b733a353a227669657773223b733a393a22646174657374616d70223b733a31303a2231353833363135373332223b733a353a226d74696d65223b693a313538333631353733323b733a333a22706870223b733a353a22352e322e34223b733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/custom/drupal_test/drupal_test.module', 'drupal_test', 'module', '', 1, 0, 0, 0, 0x613a31303a7b733a343a226e616d65223b733a31313a2244727570616c2054657374223b733a31313a226465736372697074696f6e223b733a3131313a2254686973206d6f64756c652077696c6c2064697361626c6520456d706c6f796d656e742074797065206669656c6420666f722065646974696e6720696e204a6f62204e6f64652c206966206974206973206465636c6172656420617320467265656c616e6365204a6f622074797065223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a31343a22437573746f6d206d6f64756c6573223b733a353a226d74696d65223b693a313630383130363136343b733a31323a22646570656e64656e63696573223b613a303a7b7d733a373a2276657273696f6e223b4e3b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('sites/all/modules/custom/drupal_test2/drupal_test2.module', 'drupal_test2', 'module', '', 0, 0, -1, 0, 0x613a31333a7b733a343a226e616d65223b733a31323a2244727570616c205465737432223b733a31313a226465736372697074696f6e223b733a33333a22436f6e74656e742054797065204a6f6220616e64205669657720446973706c6179223b733a343a22636f7265223b733a333a22372e78223b733a373a227061636b616765223b733a383a224665617475726573223b733a373a2276657273696f6e223b733a373a22372e782d312e30223b733a31323a22646570656e64656e63696573223b613a343a7b693a303b733a383a226665617475726573223b693a313b733a343a226c697374223b693a323b733a343a2274657874223b693a333b733a353a227669657773223b7d733a383a226665617475726573223b613a363a7b733a363a2263746f6f6c73223b613a313a7b693a303b733a32333a2276696577733a76696577735f64656661756c743a332e30223b7d733a31323a2266656174757265735f617069223b613a313a7b693a303b733a353a226170693a32223b7d733a31303a226669656c645f62617365223b613a323a7b693a303b733a343a22626f6479223b693a313b733a32313a226669656c645f656d706c6f796d656e745f74797065223b7d733a31343a226669656c645f696e7374616e6365223b613a323a7b693a303b733a31333a226e6f64652d6a6f622d626f6479223b693a313b733a33303a226e6f64652d6a6f622d6669656c645f656d706c6f796d656e745f74797065223b7d733a343a226e6f6465223b613a313a7b693a303b733a333a226a6f62223b7d733a31303a2276696577735f76696577223b613a313a7b693a303b733a343a226a6f6273223b7d7d733a31363a2266656174757265735f6578636c756465223b613a313a7b733a31323a22646570656e64656e63696573223b613a323a7b733a363a2263746f6f6c73223b733a363a2263746f6f6c73223b733a373a226f7074696f6e73223b733a373a226f7074696f6e73223b7d7d733a31323a2270726f6a6563742070617468223b733a32343a2273697465732f616c6c2f6d6f64756c65732f637573746f6d223b733a353a226d74696d65223b693a313630383034313938313b733a333a22706870223b733a353a22352e322e34223b733a353a2266696c6573223b613a303a7b7d733a393a22626f6f747374726170223b693a303b7d),
('themes/bartik/bartik.info', 'bartik', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31383a7b733a343a226e616d65223b733a363a2242617274696b223b733a31313a226465736372697074696f6e223b733a34383a224120666c657869626c652c207265636f6c6f7261626c65207468656d652077697468206d616e7920726567696f6e732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a333a7b733a31343a226373732f6c61796f75742e637373223b733a32383a227468656d65732f62617274696b2f6373732f6c61796f75742e637373223b733a31333a226373732f7374796c652e637373223b733a32373a227468656d65732f62617274696b2f6373732f7374796c652e637373223b733a31343a226373732f636f6c6f72732e637373223b733a32383a227468656d65732f62617274696b2f6373732f636f6c6f72732e637373223b7d733a353a227072696e74223b613a313a7b733a31333a226373732f7072696e742e637373223b733a32373a227468656d65732f62617274696b2f6373732f7072696e742e637373223b7d7d733a373a22726567696f6e73223b613a31373a7b733a363a22686561646572223b733a363a22486561646572223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a383a226665617475726564223b733a383a224665617475726564223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a31333a22736964656261725f6669727374223b733a31333a2253696465626172206669727374223b733a31343a22736964656261725f7365636f6e64223b733a31343a2253696465626172207365636f6e64223b733a31343a2274726970747963685f6669727374223b733a31343a225472697074796368206669727374223b733a31353a2274726970747963685f6d6964646c65223b733a31353a225472697074796368206d6964646c65223b733a31333a2274726970747963685f6c617374223b733a31333a225472697074796368206c617374223b733a31383a22666f6f7465725f6669727374636f6c756d6e223b733a31393a22466f6f74657220666972737420636f6c756d6e223b733a31393a22666f6f7465725f7365636f6e64636f6c756d6e223b733a32303a22466f6f746572207365636f6e6420636f6c756d6e223b733a31383a22666f6f7465725f7468697264636f6c756d6e223b733a31393a22466f6f74657220746869726420636f6c756d6e223b733a31393a22666f6f7465725f666f75727468636f6c756d6e223b733a32303a22466f6f74657220666f7572746820636f6c756d6e223b733a363a22666f6f746572223b733a363a22466f6f746572223b7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2230223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32383a227468656d65732f62617274696b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d),
('themes/garland/garland.info', 'garland', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 0, 0, -1, 0, 0x613a31383a7b733a343a226e616d65223b733a373a224761726c616e64223b733a31313a226465736372697074696f6e223b733a3131313a2241206d756c74692d636f6c756d6e207468656d652077686963682063616e20626520636f6e6669677572656420746f206d6f6469667920636f6c6f727320616e6420737769746368206265747765656e20666978656420616e6420666c756964207769647468206c61796f7574732e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a323a7b733a333a22616c6c223b613a313a7b733a393a227374796c652e637373223b733a32343a227468656d65732f6761726c616e642f7374796c652e637373223b7d733a353a227072696e74223b613a313a7b733a393a227072696e742e637373223b733a32343a227468656d65732f6761726c616e642f7072696e742e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a31333a226761726c616e645f7769647468223b733a353a22666c756964223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32393a227468656d65732f6761726c616e642f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d);
INSERT INTO `jbqo_system` (`filename`, `name`, `type`, `owner`, `status`, `bootstrap`, `schema_version`, `weight`, `info`) VALUES
('themes/seven/seven.info', 'seven', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 1, 0, -1, 0, 0x613a31383a7b733a343a226e616d65223b733a353a22536576656e223b733a31313a226465736372697074696f6e223b733a36353a22412073696d706c65206f6e652d636f6c756d6e2c207461626c656c6573732c20666c7569642077696474682061646d696e697374726174696f6e207468656d652e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a363a2273637265656e223b613a323a7b733a393a2272657365742e637373223b733a32323a227468656d65732f736576656e2f72657365742e637373223b733a393a227374796c652e637373223b733a32323a227468656d65732f736576656e2f7374796c652e637373223b7d7d733a383a2273657474696e6773223b613a313a7b733a32303a2273686f72746375745f6d6f64756c655f6c696e6b223b733a313a2231223b7d733a373a22726567696f6e73223b613a353a7b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b733a31333a22736964656261725f6669727374223b733a31333a2246697273742073696465626172223b7d733a31343a22726567696f6e735f68696464656e223b613a333a7b693a303b733a31333a22736964656261725f6669727374223b693a313b733a383a22706167655f746f70223b693a323b733a31313a22706167655f626f74746f6d223b7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f736576656e2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d),
('themes/stark/stark.info', 'stark', 'theme', 'themes/engines/phptemplate/phptemplate.engine', 0, 0, -1, 0, 0x613a31373a7b733a343a226e616d65223b733a353a22537461726b223b733a31313a226465736372697074696f6e223b733a3230383a2254686973207468656d652064656d6f6e737472617465732044727570616c27732064656661756c742048544d4c206d61726b757020616e6420435353207374796c65732e20546f206c6561726e20686f7720746f206275696c6420796f7572206f776e207468656d6520616e64206f766572726964652044727570616c27732064656661756c7420636f64652c2073656520746865203c6120687265663d22687474703a2f2f64727570616c2e6f72672f7468656d652d6775696465223e5468656d696e672047756964653c2f613e2e223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3737223b733a343a22636f7265223b733a333a22372e78223b733a31313a227374796c65736865657473223b613a313a7b733a333a22616c6c223b613a313a7b733a31303a226c61796f75742e637373223b733a32333a227468656d65732f737461726b2f6c61796f75742e637373223b7d7d733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231363037303033343437223b733a363a22656e67696e65223b733a31313a2270687074656d706c617465223b733a373a22726567696f6e73223b613a393a7b733a31333a22736964656261725f6669727374223b733a31323a224c6566742073696465626172223b733a31343a22736964656261725f7365636f6e64223b733a31333a2252696768742073696465626172223b733a373a22636f6e74656e74223b733a373a22436f6e74656e74223b733a363a22686561646572223b733a363a22486561646572223b733a363a22666f6f746572223b733a363a22466f6f746572223b733a31313a22686967686c696768746564223b733a31313a22486967686c696768746564223b733a343a2268656c70223b733a343a2248656c70223b733a383a22706167655f746f70223b733a383a225061676520746f70223b733a31313a22706167655f626f74746f6d223b733a31313a225061676520626f74746f6d223b7d733a383a226665617475726573223b613a393a7b693a303b733a343a226c6f676f223b693a313b733a373a2266617669636f6e223b693a323b733a343a226e616d65223b693a333b733a363a22736c6f67616e223b693a343b733a31373a226e6f64655f757365725f70696374757265223b693a353b733a32303a22636f6d6d656e745f757365725f70696374757265223b693a363b733a32353a22636f6d6d656e745f757365725f766572696669636174696f6e223b693a373b733a393a226d61696e5f6d656e75223b693a383b733a31343a227365636f6e646172795f6d656e75223b7d733a31303a2273637265656e73686f74223b733a32373a227468656d65732f737461726b2f73637265656e73686f742e706e67223b733a333a22706870223b733a353a22352e322e34223b733a373a2273637269707473223b613a303a7b7d733a353a226d74696d65223b693a313630373030333434373b733a31343a22726567696f6e735f68696464656e223b613a323a7b693a303b733a383a22706167655f746f70223b693a313b733a31313a22706167655f626f74746f6d223b7d733a32383a226f7665726c61795f737570706c656d656e74616c5f726567696f6e73223b613a313a7b693a303b733a383a22706167655f746f70223b7d7d);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_taxonomy_index`
--

CREATE TABLE `jbqo_taxonomy_index` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_node`.nid this record tracks.',
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT 0 COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'The Unix timestamp when the node was created.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_taxonomy_term_data`
--

CREATE TABLE `jbqo_taxonomy_term_data` (
  `tid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The `jbqo_taxonomy_vocabulary`.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext DEFAULT NULL COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The `jbqo_filter_format`.format of the description.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'The weight of this term in relation to other terms.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_taxonomy_term_hierarchy`
--

CREATE TABLE `jbqo_taxonomy_term_hierarchy` (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Primary Key: The `jbqo_taxonomy_term_data`.tid of the term.',
  `parent` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Primary Key: The `jbqo_taxonomy_term_data`.tid of the term’s parent. 0 indicates no parent.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_taxonomy_vocabulary`
--

CREATE TABLE `jbqo_taxonomy_vocabulary` (
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext DEFAULT NULL COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT 'The weight of this vocabulary in relation to other vocabularies.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';

--
-- Dumping data for table `jbqo_taxonomy_vocabulary`
--

INSERT INTO `jbqo_taxonomy_vocabulary` (`vid`, `name`, `machine_name`, `description`, `hierarchy`, `module`, `weight`) VALUES
(1, 'Tags', 'tags', 'Use tags to group articles on similar topics into categories.', 0, 'taxonomy', 0);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_url_alias`
--

CREATE TABLE `jbqo_url_alias` (
  `pid` int(10) UNSIGNED NOT NULL COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_users`
--

CREATE TABLE `jbqo_users` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The `jbqo_filter_format`.format of the signature.',
  `created` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT 0 COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT 0 COMMENT 'Foreign key: `jbqo_file_managed`.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob DEFAULT NULL COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';

--
-- Dumping data for table `jbqo_users`
--

INSERT INTO `jbqo_users` (`uid`, `name`, `pass`, `mail`, `theme`, `signature`, `signature_format`, `created`, `access`, `login`, `status`, `timezone`, `language`, `picture`, `init`, `data`) VALUES
(0, '', '', '', '', '', NULL, 0, 0, 0, 0, NULL, '', 0, '', NULL),
(1, 'vradova', '$S$DxTLnAQiX5CkvaMnrxWIDjNBGCpmdEAb/aOIZnKsgaRe2x7Cmtjo', 'office@digitalstuff.agency', '', '', NULL, 1608028596, 1608106262, 1608104967, 1, 'Europe/Paris', '', 0, 'office@digitalstuff.agency', 0x623a303b);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_users_roles`
--

CREATE TABLE `jbqo_users_roles` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Primary Key: `jbqo_users`.uid for user.',
  `rid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Primary Key: `jbqo_role`.rid for role.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

--
-- Dumping data for table `jbqo_users_roles`
--

INSERT INTO `jbqo_users_roles` (`uid`, `rid`) VALUES
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_variable`
--

CREATE TABLE `jbqo_variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

--
-- Dumping data for table `jbqo_variable`
--

INSERT INTO `jbqo_variable` (`name`, `value`) VALUES
('additional_settings__active_tab_job', 0x733a31353a22656469742d7375626d697373696f6e223b),
('admin_theme', 0x733a353a22736576656e223b),
('cache_class_cache_ctools_css', 0x733a31343a2243546f6f6c734373734361636865223b),
('clean_url', 0x733a313a2231223b),
('comment_anonymous_job', 0x693a303b),
('comment_default_mode_job', 0x693a313b),
('comment_default_per_page_job', 0x733a323a223530223b),
('comment_form_location_job', 0x693a313b),
('comment_job', 0x733a313a2231223b),
('comment_page', 0x693a303b),
('comment_preview_job', 0x733a313a2231223b),
('comment_subject_field_job', 0x693a313b),
('cron_key', 0x733a34333a227139776f455365397743586c4336593176434176446e6e5456766a544f6670526e64536c4639746c624273223b),
('cron_last', 0x693a313630383130363236393b),
('css_js_query_string', 0x733a363a22716c66617171223b),
('ctools_last_cron', 0x693a313630383032393036363b),
('dashboard_stashed_blocks', 0x613a353a7b693a303b613a333a7b733a363a226d6f64756c65223b733a343a226e6f6465223b733a353a2264656c7461223b733a363a22726563656e74223b733a363a22726567696f6e223b733a31343a2264617368626f6172645f6d61696e223b7d693a313b613a333a7b733a363a226d6f64756c65223b733a343a2275736572223b733a353a2264656c7461223b733a333a226e6577223b733a363a22726567696f6e223b733a31373a2264617368626f6172645f73696465626172223b7d693a323b613a333a7b733a363a226d6f64756c65223b733a363a22736561726368223b733a353a2264656c7461223b733a343a22666f726d223b733a363a22726567696f6e223b733a31373a2264617368626f6172645f73696465626172223b7d693a333b613a333a7b733a363a226d6f64756c65223b733a373a22636f6d6d656e74223b733a353a2264656c7461223b733a363a22726563656e74223b733a363a22726567696f6e223b733a31383a2264617368626f6172645f696e616374697665223b7d693a343b613a333a7b733a363a226d6f64756c65223b733a343a2275736572223b733a353a2264656c7461223b733a363a226f6e6c696e65223b733a363a22726567696f6e223b733a31383a2264617368626f6172645f696e616374697665223b7d7d),
('date_default_timezone', 0x733a31323a224575726f70652f5061726973223b),
('drupal_http_request_fails', 0x623a303b),
('drupal_private_key', 0x733a34333a22653831695156335561516833796871464c7a6846347952643157627645786136612d77696379595f6d4263223b),
('features_ignored_orphans', 0x613a303a7b7d),
('features_modules_changed', 0x623a303b),
('field_bundle_settings_node__job', 0x613a323a7b733a31303a22766965775f6d6f646573223b613a303a7b7d733a31323a2265787472615f6669656c6473223b613a323a7b733a343a22666f726d223b613a313a7b733a353a227469746c65223b613a313a7b733a363a22776569676874223b733a323a222d35223b7d7d733a373a22646973706c6179223b613a303a7b7d7d7d),
('file_temporary_path', 0x733a343a222f746d70223b),
('filter_fallback_format', 0x733a31303a22706c61696e5f74657874223b),
('install_profile', 0x733a383a227374616e64617264223b),
('install_task', 0x733a343a22646f6e65223b),
('install_time', 0x693a313630383032383731313b),
('menu_expanded', 0x613a303a7b7d),
('menu_masks', 0x613a33353a7b693a303b693a3530313b693a313b693a3439333b693a323b693a3235303b693a333b693a3234373b693a343b693a3234363b693a353b693a3234353b693a363b693a3132353b693a373b693a3132343b693a383b693a3132333b693a393b693a3132323b693a31303b693a3132313b693a31313b693a3131373b693a31323b693a36333b693a31333b693a36323b693a31343b693a36313b693a31353b693a36303b693a31363b693a35393b693a31373b693a35383b693a31383b693a34343b693a31393b693a33313b693a32303b693a33303b693a32313b693a32393b693a32323b693a32373b693a32333b693a32343b693a32343b693a32313b693a32353b693a31353b693a32363b693a31343b693a32373b693a31333b693a32383b693a31313b693a32393b693a373b693a33303b693a363b693a33313b693a353b693a33323b693a333b693a33333b693a323b693a33343b693a313b7d),
('menu_options_job', 0x613a313a7b693a303b733a393a226d61696e2d6d656e75223b7d),
('menu_parent_job', 0x733a31313a226d61696e2d6d656e753a30223b),
('node_admin_theme', 0x733a313a2231223b),
('node_cron_last', 0x733a31303a2231363038303431373734223b),
('node_options_job', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_options_page', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_preview_job', 0x733a313a2230223b),
('node_submitted_job', 0x693a303b),
('node_submitted_page', 0x623a303b),
('path_alias_whitelist', 0x613a303a7b7d),
('save_continue_job', 0x733a31393a225361766520616e6420616464206669656c6473223b),
('site_default_country', 0x733a323a225253223b),
('site_mail', 0x733a32363a226f6666696365406469676974616c73747566662e6167656e6379223b),
('site_name', 0x733a32303a2244727570616c2054657374202d204a6f6269716f223b),
('theme_default', 0x733a363a2262617274696b223b),
('update_last_check', 0x693a313630383130363232343b),
('update_notify_emails', 0x613a313a7b693a303b733a32363a226f6666696365406469676974616c73747566662e6167656e6379223b7d),
('user_admin_role', 0x733a313a2233223b),
('user_pictures', 0x733a313a2231223b),
('user_picture_dimensions', 0x733a393a22313032347831303234223b),
('user_picture_file_size', 0x733a333a22383030223b),
('user_picture_style', 0x733a393a227468756d626e61696c223b),
('user_register', 0x693a323b),
('views_exposed_filter_any_label', 0x733a373a226e65775f616e79223b),
('views_show_additional_queries', 0x693a303b),
('views_ui_always_live_preview', 0x693a313b),
('views_ui_custom_theme', 0x733a383a225f64656661756c74223b),
('views_ui_display_embed', 0x693a303b),
('views_ui_show_advanced_column', 0x693a313b),
('views_ui_show_advanced_help_warning', 0x693a313b),
('views_ui_show_listing_filters', 0x693a313b),
('views_ui_show_master_display', 0x693a313b),
('views_ui_show_performance_statistics', 0x693a303b),
('views_ui_show_preview_information', 0x693a313b),
('views_ui_show_sql_query', 0x693a303b),
('views_ui_show_sql_query_where', 0x733a353a2262656c6f77223b);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_views_display`
--

CREATE TABLE `jbqo_views_display` (
  `vid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL DEFAULT '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL DEFAULT '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) DEFAULT 0 COMMENT 'The order in which this display is loaded.',
  `display_options` longtext DEFAULT NULL COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';

--
-- Dumping data for table `jbqo_views_display`
--

INSERT INTO `jbqo_views_display` (`vid`, `id`, `display_title`, `display_plugin`, `position`, `display_options`) VALUES
(1, 'default', 'Master', 'default', 1, 'a:11:{s:5:\"query\";a:2:{s:4:\"type\";s:11:\"views_query\";s:7:\"options\";a:0:{}}s:6:\"access\";a:2:{s:4:\"type\";s:4:\"perm\";s:4:\"perm\";s:14:\"access content\";}s:5:\"cache\";a:1:{s:4:\"type\";s:4:\"none\";}s:12:\"exposed_form\";a:1:{s:4:\"type\";s:5:\"basic\";}s:5:\"pager\";a:2:{s:4:\"type\";s:4:\"full\";s:7:\"options\";a:1:{s:14:\"items_per_page\";s:2:\"10\";}}s:12:\"style_plugin\";s:5:\"table\";s:10:\"row_plugin\";s:6:\"fields\";s:6:\"fields\";a:3:{s:5:\"title\";a:22:{s:2:\"id\";s:5:\"title\";s:5:\"table\";s:4:\"node\";s:5:\"field\";s:5:\"title\";s:12:\"relationship\";s:4:\"none\";s:10:\"group_type\";s:5:\"group\";s:7:\"ui_name\";s:0:\"\";s:5:\"label\";s:5:\"Title\";s:7:\"exclude\";i:0;s:5:\"alter\";a:27:{s:10:\"alter_text\";i:0;s:4:\"text\";s:0:\"\";s:9:\"make_link\";i:0;s:4:\"path\";s:0:\"\";s:8:\"absolute\";i:0;s:8:\"external\";i:0;s:14:\"replace_spaces\";i:0;s:19:\"unwanted_characters\";s:0:\"\";s:9:\"path_case\";s:4:\"none\";s:15:\"trim_whitespace\";i:0;s:3:\"alt\";s:0:\"\";s:3:\"rel\";s:0:\"\";s:10:\"link_class\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:6:\"target\";s:0:\"\";s:5:\"nl2br\";i:0;s:10:\"max_length\";s:0:\"\";s:13:\"word_boundary\";i:0;s:8:\"ellipsis\";i:0;s:9:\"more_link\";i:0;s:14:\"more_link_text\";s:0:\"\";s:14:\"more_link_path\";s:0:\"\";s:10:\"strip_tags\";i:0;s:4:\"trim\";i:0;s:13:\"preserve_tags\";s:0:\"\";s:4:\"html\";i:0;}s:12:\"element_type\";s:0:\"\";s:13:\"element_class\";s:0:\"\";s:18:\"element_label_type\";s:0:\"\";s:19:\"element_label_class\";s:0:\"\";s:19:\"element_label_colon\";i:1;s:20:\"element_wrapper_type\";s:0:\"\";s:21:\"element_wrapper_class\";s:0:\"\";s:23:\"element_default_classes\";i:1;s:5:\"empty\";s:0:\"\";s:10:\"hide_empty\";i:0;s:10:\"empty_zero\";i:0;s:16:\"hide_alter_empty\";i:1;s:12:\"link_to_node\";i:1;}s:21:\"field_employment_type\";a:35:{s:2:\"id\";s:21:\"field_employment_type\";s:5:\"table\";s:32:\"field_data_field_employment_type\";s:5:\"field\";s:21:\"field_employment_type\";s:12:\"relationship\";s:4:\"none\";s:10:\"group_type\";s:5:\"group\";s:7:\"ui_name\";s:0:\"\";s:5:\"label\";s:15:\"Employment type\";s:7:\"exclude\";i:0;s:5:\"alter\";a:27:{s:10:\"alter_text\";i:0;s:4:\"text\";s:0:\"\";s:9:\"make_link\";i:0;s:4:\"path\";s:0:\"\";s:8:\"absolute\";i:0;s:8:\"external\";i:0;s:14:\"replace_spaces\";i:0;s:19:\"unwanted_characters\";s:0:\"\";s:9:\"path_case\";s:4:\"none\";s:15:\"trim_whitespace\";i:0;s:3:\"alt\";s:0:\"\";s:3:\"rel\";s:0:\"\";s:10:\"link_class\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:6:\"target\";s:0:\"\";s:5:\"nl2br\";i:0;s:10:\"max_length\";s:0:\"\";s:13:\"word_boundary\";i:1;s:8:\"ellipsis\";i:1;s:9:\"more_link\";i:0;s:14:\"more_link_text\";s:0:\"\";s:14:\"more_link_path\";s:0:\"\";s:10:\"strip_tags\";i:0;s:4:\"trim\";i:0;s:13:\"preserve_tags\";s:0:\"\";s:4:\"html\";i:0;}s:12:\"element_type\";s:0:\"\";s:13:\"element_class\";s:0:\"\";s:18:\"element_label_type\";s:0:\"\";s:19:\"element_label_class\";s:0:\"\";s:19:\"element_label_colon\";i:1;s:20:\"element_wrapper_type\";s:0:\"\";s:21:\"element_wrapper_class\";s:0:\"\";s:23:\"element_default_classes\";i:1;s:5:\"empty\";s:0:\"\";s:10:\"hide_empty\";i:0;s:10:\"empty_zero\";i:0;s:16:\"hide_alter_empty\";i:1;s:17:\"click_sort_column\";s:5:\"value\";s:4:\"type\";s:12:\"list_default\";s:8:\"settings\";a:0:{}s:12:\"group_column\";s:5:\"value\";s:13:\"group_columns\";a:0:{}s:10:\"group_rows\";b:1;s:11:\"delta_limit\";s:3:\"all\";s:12:\"delta_offset\";i:0;s:14:\"delta_reversed\";b:0;s:16:\"delta_first_last\";b:0;s:12:\"delta_random\";b:0;s:10:\"multi_type\";s:9:\"separator\";s:9:\"separator\";s:2:\", \";s:17:\"field_api_classes\";i:0;}s:7:\"created\";a:26:{s:2:\"id\";s:7:\"created\";s:5:\"table\";s:4:\"node\";s:5:\"field\";s:7:\"created\";s:12:\"relationship\";s:4:\"none\";s:10:\"group_type\";s:5:\"group\";s:7:\"ui_name\";s:0:\"\";s:5:\"label\";s:12:\"Created date\";s:7:\"exclude\";i:0;s:5:\"alter\";a:27:{s:10:\"alter_text\";i:0;s:4:\"text\";s:0:\"\";s:9:\"make_link\";i:0;s:4:\"path\";s:0:\"\";s:8:\"absolute\";i:0;s:8:\"external\";i:0;s:14:\"replace_spaces\";i:0;s:19:\"unwanted_characters\";s:0:\"\";s:9:\"path_case\";s:4:\"none\";s:15:\"trim_whitespace\";i:0;s:3:\"alt\";s:0:\"\";s:3:\"rel\";s:0:\"\";s:10:\"link_class\";s:0:\"\";s:6:\"prefix\";s:0:\"\";s:6:\"suffix\";s:0:\"\";s:6:\"target\";s:0:\"\";s:5:\"nl2br\";i:0;s:10:\"max_length\";s:0:\"\";s:13:\"word_boundary\";i:1;s:8:\"ellipsis\";i:1;s:9:\"more_link\";i:0;s:14:\"more_link_text\";s:0:\"\";s:14:\"more_link_path\";s:0:\"\";s:10:\"strip_tags\";i:0;s:4:\"trim\";i:0;s:13:\"preserve_tags\";s:0:\"\";s:4:\"html\";i:0;}s:12:\"element_type\";s:0:\"\";s:13:\"element_class\";s:0:\"\";s:18:\"element_label_type\";s:0:\"\";s:19:\"element_label_class\";s:0:\"\";s:19:\"element_label_colon\";i:1;s:20:\"element_wrapper_type\";s:0:\"\";s:21:\"element_wrapper_class\";s:0:\"\";s:23:\"element_default_classes\";i:1;s:5:\"empty\";s:0:\"\";s:10:\"hide_empty\";i:0;s:10:\"empty_zero\";i:0;s:16:\"hide_alter_empty\";i:1;s:11:\"date_format\";s:4:\"long\";s:18:\"custom_date_format\";s:0:\"\";s:25:\"second_date_format_custom\";s:0:\"\";s:18:\"second_date_format\";s:4:\"long\";s:8:\"timezone\";s:15:\"Europe/Belgrade\";}}s:7:\"filters\";a:2:{s:6:\"status\";a:6:{s:5:\"value\";i:1;s:5:\"table\";s:4:\"node\";s:5:\"field\";s:6:\"status\";s:2:\"id\";s:6:\"status\";s:6:\"expose\";a:1:{s:8:\"operator\";b:0;}s:5:\"group\";i:1;}s:4:\"type\";a:4:{s:2:\"id\";s:4:\"type\";s:5:\"table\";s:4:\"node\";s:5:\"field\";s:4:\"type\";s:5:\"value\";a:1:{s:3:\"job\";s:3:\"job\";}}}s:5:\"sorts\";a:1:{s:7:\"created\";a:4:{s:2:\"id\";s:7:\"created\";s:5:\"table\";s:4:\"node\";s:5:\"field\";s:7:\"created\";s:5:\"order\";s:4:\"DESC\";}}s:5:\"title\";s:4:\"Jobs\";}'),
(1, 'page', 'Page', 'page', 2, 'a:3:{s:5:\"query\";a:2:{s:4:\"type\";s:11:\"views_query\";s:7:\"options\";a:0:{}}s:4:\"path\";s:4:\"jobs\";s:4:\"menu\";a:7:{s:4:\"type\";s:6:\"normal\";s:5:\"title\";s:4:\"Jobs\";s:11:\"description\";s:0:\"\";s:4:\"name\";s:9:\"main-menu\";s:6:\"weight\";s:1:\"0\";s:7:\"context\";i:0;s:19:\"context_only_inline\";i:0;}}');

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_views_view`
--

CREATE TABLE `jbqo_views_view` (
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) DEFAULT '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) DEFAULT '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL DEFAULT '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) DEFAULT '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) DEFAULT 0 COMMENT 'Stores the drupal core version of the view.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';

--
-- Dumping data for table `jbqo_views_view`
--

INSERT INTO `jbqo_views_view` (`vid`, `name`, `description`, `tag`, `base_table`, `human_name`, `core`) VALUES
(1, 'jobs', '', 'default', 'node', 'Jobs', 7);

-- --------------------------------------------------------

--
-- Table structure for table `jbqo_watchdog`
--

CREATE TABLE `jbqo_watchdog` (
  `wid` int(11) NOT NULL COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT 'The `jbqo_users`.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text DEFAULT NULL COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT 0 COMMENT 'Unix timestamp of when event occurred.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';

--
-- Dumping data for table `jbqo_watchdog`
--

INSERT INTO `jbqo_watchdog` (`wid`, `uid`, `type`, `message`, `variables`, `severity`, `link`, `location`, `referer`, `hostname`, `timestamp`) VALUES
(1, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a2264626c6f67223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(2, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a2264626c6f67223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(3, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a226669656c645f7569223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(4, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a226669656c645f7569223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(5, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2266696c65223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(6, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2266696c65223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(7, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7074696f6e73223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(8, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7074696f6e73223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(9, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227461786f6e6f6d79223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(10, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227461786f6e6f6d79223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(11, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2268656c70223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(12, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2268656c70223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(13, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a22696d616765223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(14, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a22696d616765223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(15, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a226c697374223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(16, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a226c697374223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(17, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a226d656e75223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028598),
(18, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a226d656e75223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(19, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a226e756d626572223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(20, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a226e756d626572223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(21, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7665726c6179223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(22, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7665726c6179223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(23, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2270617468223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(24, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a343a2270617468223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(25, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a333a22726466223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(26, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a333a22726466223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(27, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22736561726368223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(28, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22736561726368223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(29, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a2273686f7274637574223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(30, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a2273686f7274637574223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(31, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a22746f6f6c626172223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(32, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a22746f6f6c626172223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028599),
(33, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227374616e64617264223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(34, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a227374616e64617264223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=do', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(35, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31353a225075626c69736820636f6d6d656e74223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(36, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31373a22556e7075626c69736820636f6d6d656e74223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(37, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31323a225361766520636f6d6d656e74223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(38, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31353a225075626c69736820636f6e74656e74223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(39, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31373a22556e7075626c69736820636f6e74656e74223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(40, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31393a224d616b6520636f6e74656e7420737469636b79223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(41, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a32313a224d616b6520636f6e74656e7420756e737469636b79223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(42, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a32393a2250726f6d6f746520636f6e74656e7420746f2066726f6e742070616765223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(43, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a33303a2252656d6f766520636f6e74656e742066726f6d2066726f6e742070616765223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(44, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31323a225361766520636f6e74656e74223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(45, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a33303a2242616e2049502061646472657373206f662063757272656e742075736572223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(46, 0, 'actions', 'Action \'%action\' added.', 0x613a313a7b733a373a2225616374696f6e223b733a31383a22426c6f636b2063757272656e742075736572223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&id=1&op=finished', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en&op=start&id=1', '212.200.181.102', 1608028600),
(47, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22757064617465223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', '212.200.181.102', 1608028712),
(48, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a22757064617465223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', '212.200.181.102', 1608028712),
(49, 1, 'user', 'Session opened for %name.', 0x613a313a7b733a353a22256e616d65223b733a373a22767261646f7661223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', '212.200.181.102', 1608028712),
(50, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', 'https://digitalstuff.dev/DrupalTest/web/install.php?profile=standard&locale=en', '212.200.181.102', 1608028712),
(51, 1, 'content', '@type: added %title.', 0x613a323a7b733a353a224074797065223b733a373a2261727469636c65223b733a363a22257469746c65223b733a31313a2244727570616c2074657374223b7d, 5, '<a href=\"/DrupalTest/web/node/1\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/add/article?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/node/add/article?render=overlay', '212.200.181.102', 1608028764),
(52, 1, 'node', 'Added content type %name.', 0x613a313a7b733a353a22256e616d65223b733a333a226a6f62223b7d, 5, '<a href=\"/DrupalTest/web/admin/structure/types\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/types/add?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/types/add?render=overlay', '212.200.181.102', 1608028842),
(53, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a2263746f6f6c73223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608029059),
(54, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a363a2263746f6f6c73223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608029059),
(55, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a227669657773223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608029059),
(56, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a227669657773223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608029059),
(57, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a2276696577735f7569223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608029059),
(58, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a2276696577735f7569223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608029059),
(59, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'http://default/', '', '127.0.0.1', 1608029067),
(60, 1, 'content', '@type: added %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622031223b7d, 5, '<a href=\"/DrupalTest/web/node/2\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay', '212.200.181.102', 1608029823),
(61, 1, 'content', '@type: added %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622032223b7d, 5, '<a href=\"/DrupalTest/web/node/3\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay', '212.200.181.102', 1608029911),
(62, 1, 'content', '@type: added %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622033223b7d, 5, '<a href=\"/DrupalTest/web/node/4\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay', '212.200.181.102', 1608029929),
(63, 1, 'content', '@type: added %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622034223b7d, 5, '<a href=\"/DrupalTest/web/node/5\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay', '212.200.181.102', 1608029945),
(64, 1, 'content', '@type: added %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622035223b7d, 5, '<a href=\"/DrupalTest/web/node/6\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay&render=overlay', 'https://digitalstuff.dev/DrupalTest/web/node/add/job?render=overlay', '212.200.181.102', 1608029958),
(65, 1, 'system', '%module module disabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a373a226f7665726c6179223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm?render=overlay', 'https://digitalstuff.dev/DrupalTest/web/admin/modules?render=overlay', '212.200.181.102', 1608030351),
(66, 1, 'system', '%module module disabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a393a2264617368626f617264223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm?render=overlay', 'https://digitalstuff.dev/DrupalTest/web/admin/modules?render=overlay', '212.200.181.102', 1608030351),
(67, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/reports/status/run-cron?destination=admin/modules', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608030355),
(68, 1, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a22646576656c223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608031429),
(69, 1, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a353a22646576656c223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608031429),
(70, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/reports/status/run-cron?destination=admin/modules', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608031436),
(71, 1, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a31313a2264727570616c5f74657374223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608032238),
(72, 1, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31313a2264727570616c5f74657374223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608032238),
(73, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/reports/status/run-cron?destination=admin/modules', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.102', 1608032242),
(74, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a31393a22556e646566696e6564206f66667365743a2030223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032246),
(75, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032246),
(76, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032246),
(77, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32373a22496c6c6567616c20737472696e67206f66667365742027756e6427223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a393b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032354),
(78, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a33363a2243616e6e6f742075736520737472696e67206f666673657420617320616e206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a393b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032354),
(79, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33333a22496c6c6567616c20737472696e67206f666673657420272364697361626c656427223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a393b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(80, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(81, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(82, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(83, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(84, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(85, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(86, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(87, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(88, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(89, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(90, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a34333a2241206e6f6e2077656c6c20666f726d6564206e756d657269632076616c756520656e636f756e7465726564223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(91, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032378),
(92, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33333a22496c6c6567616c20737472696e67206f666673657420272364697361626c656427223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a393b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(93, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(94, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(95, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(96, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(97, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(98, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(99, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(100, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(101, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(102, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(103, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a34333a2241206e6f6e2077656c6c20666f726d6564206e756d657269632076616c756520656e636f756e7465726564223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(104, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032475),
(105, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(106, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272361636365737327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(107, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900);
INSERT INTO `jbqo_watchdog` (`wid`, `uid`, `type`, `message`, `variables`, `severity`, `link`, `location`, `referer`, `hostname`, `timestamp`) VALUES
(108, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(109, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(110, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(111, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(112, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(113, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(114, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(115, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(116, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a34333a2241206e6f6e2077656c6c20666f726d6564206e756d657269632076616c756520656e636f756e7465726564223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(117, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608032900),
(118, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(119, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272361636365737327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(120, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(121, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(122, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(123, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(124, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(125, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(126, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(127, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(128, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(129, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a34333a2241206e6f6e2077656c6c20666f726d6564206e756d657269632076616c756520656e636f756e7465726564223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(130, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033051),
(131, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033204),
(132, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033234),
(133, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033306),
(134, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.181.102', 1608033367),
(135, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608034625),
(136, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a383b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608034725),
(137, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a36313a2273796e746178206572726f722c20756e65787065637465642026233033393b7d26233033393b2c20657870656374696e6720656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31333b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608035297),
(138, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a36313a2273796e746178206572726f722c20756e65787065637465642026233033393b7d26233033393b2c20657870656374696e6720656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31333b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608035325),
(139, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a36313a2273796e746178206572726f722c20756e65787065637465642026233033393b7d26233033393b2c20657870656374696e6720656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31333b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608035342),
(140, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a33363a2273796e746178206572726f722c20756e657870656374656420656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31363b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608035909),
(141, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a33363a2273796e746178206572726f722c20756e657870656374656420656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608035929),
(142, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a33363a2273796e746178206572726f722c20756e657870656374656420656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608035946),
(143, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31323b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036002),
(144, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31323b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036014),
(145, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34333a2243616e6e6f7420757365206f626a656374206f66207479706520737464436c617373206173206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31323b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036077),
(146, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(147, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272361636365737327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(148, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(149, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(150, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(151, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(152, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(153, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(154, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(155, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(156, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(157, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036113),
(158, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(159, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(160, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(161, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(162, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(163, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(164, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(165, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(166, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(167, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4', '212.200.247.75', 1608036133),
(168, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622033223b7d, 5, '<a href=\"/DrupalTest/web/node/4\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', '212.200.247.75', 1608036431),
(169, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622033223b7d, 5, '<a href=\"/DrupalTest/web/node/4\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', '212.200.247.75', 1608036438),
(170, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(171, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33333a22496c6c6567616c20737472696e67206f666673657420272364697361626c656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313931343b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(172, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(173, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(174, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571);
INSERT INTO `jbqo_watchdog` (`wid`, `uid`, `type`, `message`, `variables`, `severity`, `link`, `location`, `referer`, `hostname`, `timestamp`) VALUES
(175, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(176, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(177, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(178, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(179, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(180, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.247.75', 1608036571),
(181, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622033223b7d, 5, '<a href=\"/DrupalTest/web/node/4\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', '212.200.247.75', 1608037226),
(182, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622033223b7d, 5, '<a href=\"/DrupalTest/web/node/4\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', 'https://digitalstuff.dev/DrupalTest/web/node/4/edit', '212.200.247.75', 1608037246),
(183, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a33383a2273796e746178206572726f722c20756e65787065637465642026233033393b7b26233033393b223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31333b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608038347),
(184, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a36333a2273796e746178206572726f722c20756e65787065637465642026233033393b26616d703b26616d703b26233033393b2028545f424f4f4c45414e5f414e4429223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608039099),
(185, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a36313a2273796e746178206572726f722c20756e65787065637465642026233033393b7d26233033393b2c20657870656374696e6720656e64206f662066696c65223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31353b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608039130),
(186, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33373a2243616e6e6f74207573652061207363616c61722076616c756520617320616e206172726179223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(187, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33373a2243616e6e6f74207573652061207363616c61722076616c756520617320616e206172726179223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313931343b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(188, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35303a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f66207479706520696e74223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(189, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33373a2243616e6e6f74207573652061207363616c61722076616c756520617320616e206172726179223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(190, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33373a2243616e6e6f74207573652061207363616c61722076616c756520617320616e206172726179223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(191, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33373a2243616e6e6f74207573652061207363616c61722076616c756520617320616e206172726179223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(192, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33373a2243616e6e6f74207573652061207363616c61722076616c756520617320616e206172726179223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(193, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039293),
(194, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313930323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(195, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33333a22496c6c6567616c20737472696e67206f666673657420272364697361626c656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313931343b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(196, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32393a22496c6c6567616c20737472696e67206f66667365742027237472656527223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(197, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33323a22496c6c6567616c20737472696e67206f6666736574202723706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(198, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932323b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(199, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33383a22496c6c6567616c20737472696e67206f666673657420272361727261795f706172656e747327223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(200, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32363a22417272617920746f20737472696e6720636f6e76657273696f6e223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313932373b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(201, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33313a22496c6c6567616c20737472696e67206f666673657420272377656967687427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313933313b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(202, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a33343a22496c6c6567616c20737472696e67206f666673657420272370726f63657373656427223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(203, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a34383a2243616e6e6f742061737369676e20616e20656d70747920737472696e6720746f206120737472696e67206f6666736574223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313831303b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(204, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a32353a22556e737570706f72746564206f706572616e64207479706573223b733a393a222566756e6374696f6e223b733a31343a22666f726d5f6275696c6465722829223b733a353a222566696c65223b733a37303a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f696e636c756465732f666f726d2e696e63223b733a353a22256c696e65223b693a313832303b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608039589),
(205, 0, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a31303a2250617273654572726f72223b733a383a22216d657373616765223b733a33383a2273796e746178206572726f722c20756e65787065637465642026233033393b7d26233033393b223b733a393a222566756e6374696f6e223b733a31333a2264727570616c5f6c6f61642829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31343b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'http://default/', '', '127.0.0.1', 1608039720),
(206, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a36303a22547279696e6720746f206765742070726f706572747920276669656c645f656d706c6f796d656e745f7479706527206f66206e6f6e2d6f626a656374223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040198),
(207, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040198),
(208, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040198),
(209, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040198),
(210, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a33303a2246756e6374696f6e206e616d65206d757374206265206120737472696e67223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040356),
(211, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a353a224572726f72223b733a383a22216d657373616765223b733a34353a2243616c6c20746f2061206d656d6265722066756e6374696f6e2067657456616c75652829206f6e206172726179223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a333b7d, 3, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040539),
(212, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32333a22556e646566696e656420696e6465783a20776964676574223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040608),
(213, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', 'https://digitalstuff.dev/DrupalTest/web/node/6', '212.200.181.117', 1608040608),
(214, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a20236e6f6465223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040689),
(215, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a36303a22547279696e6720746f206765742070726f706572747920276669656c645f656d706c6f796d656e745f7479706527206f66206e6f6e2d6f626a656374223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040689),
(216, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040689),
(217, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040689),
(218, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040689),
(219, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a20236e6f6465223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040692),
(220, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a36303a22547279696e6720746f206765742070726f706572747920276669656c645f656d706c6f796d656e745f7479706527206f66206e6f6e2d6f626a656374223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040692),
(221, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040692),
(222, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040692),
(223, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040692),
(224, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a20236e6f6465223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040694),
(225, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a36303a22547279696e6720746f206765742070726f706572747920276669656c645f656d706c6f796d656e745f7479706527206f66206e6f6e2d6f626a656374223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040694),
(226, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040694),
(227, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040694),
(228, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/content', 'https://digitalstuff.dev/DrupalTest/web/node/6/edit', '212.200.181.117', 1608040694),
(229, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a32323a22556e646566696e656420696e6465783a20236e6f6465223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4', 'https://digitalstuff.dev/DrupalTest/web/admin/content', '212.200.181.117', 1608040697),
(230, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a36303a22547279696e6720746f206765742070726f706572747920276669656c645f656d706c6f796d656e745f7479706527206f66206e6f6e2d6f626a656374223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4', 'https://digitalstuff.dev/DrupalTest/web/admin/content', '212.200.181.117', 1608040697),
(231, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4', 'https://digitalstuff.dev/DrupalTest/web/admin/content', '212.200.181.117', 1608040697),
(232, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4', 'https://digitalstuff.dev/DrupalTest/web/admin/content', '212.200.181.117', 1608040697),
(233, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a35313a22547279696e6720746f20616363657373206172726179206f6666736574206f6e2076616c7565206f662074797065206e756c6c223b733a393a222566756e6374696f6e223b733a32343a2264727570616c5f746573745f666f726d5f616c7465722829223b733a353a222566696c65223b733a3130383a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f637573746f6d2f64727570616c5f746573742f64727570616c5f746573742e6d6f64756c65223b733a353a22256c696e65223b693a31313b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node/4', 'https://digitalstuff.dev/DrupalTest/web/admin/content', '212.200.181.117', 1608040697),
(234, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622034223b7d, 5, '<a href=\"/DrupalTest/web/node/5\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/5/edit', 'https://digitalstuff.dev/DrupalTest/web/node/5/edit', '212.200.181.117', 1608040761),
(235, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622034223b7d, 5, '<a href=\"/DrupalTest/web/node/5\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/5/edit', 'https://digitalstuff.dev/DrupalTest/web/node/5/edit', '212.200.181.117', 1608040768),
(236, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622032223b7d, 5, '<a href=\"/DrupalTest/web/node/3\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/3/edit', 'https://digitalstuff.dev/DrupalTest/web/node/3/edit', '212.200.181.117', 1608040988),
(237, 0, 'system', '%module module installed.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a226665617475726573223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608041080),
(238, 0, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a383a226665617475726573223b7d, 6, '', 'http://default/', '', '127.0.0.1', 1608041080),
(239, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'http://default/', '', '127.0.0.1', 1608041085),
(240, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a363a224e6f74696365223b733a383a22216d657373616765223b733a34333a22547279696e6720746f206765742070726f706572747920276e616d6527206f66206e6f6e2d6f626a656374223b733a393a222566756e6374696f6e223b733a33343a225f66656174757265735f6578706f72745f666f726d5f636f6d706f6e656e74732829223b733a353a222566696c65223b733a3130363a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f636f6e747269622f66656174757265732f66656174757265732e61646d696e2e696e63223b733a353a22256c696e65223b693a3431353b733a31343a2273657665726974795f6c6576656c223b693a353b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/system/ajax', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', '212.200.181.117', 1608041393),
(241, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a32363a226d6b64697228293a205065726d697373696f6e2064656e696564223b733a393a222566756e6374696f6e223b733a33353a2266656174757265735f6578706f72745f6275696c645f666f726d5f7375626d69742829223b733a353a222566696c65223b733a3130363a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f636f6e747269622f66656174757265732f66656174757265732e61646d696e2e696e63223b733a353a22256c696e65223b693a3939343b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', '212.200.181.117', 1608041488);
INSERT INTO `jbqo_watchdog` (`wid`, `uid`, `type`, `message`, `variables`, `severity`, `link`, `location`, `referer`, `hostname`, `timestamp`) VALUES
(242, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a3130373a2266696c655f7075745f636f6e74656e7473282f637573746f6d2f64727570616c5f74657374322f64727570616c5f74657374322e696e666f293a206661696c656420746f206f70656e2073747265616d3a204e6f20737563682066696c65206f72206469726563746f7279223b733a393a222566756e6374696f6e223b733a33353a2266656174757265735f6578706f72745f6275696c645f666f726d5f7375626d69742829223b733a353a222566696c65223b733a3130363a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f636f6e747269622f66656174757265732f66656174757265732e61646d696e2e696e63223b733a353a22256c696e65223b693a313034383b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', '212.200.181.117', 1608041488),
(243, 1, 'php', '%type: !message in %function (line %line of %file).', 0x613a363a7b733a353a222574797065223b733a373a225761726e696e67223b733a383a22216d657373616765223b733a3130393a2266696c655f7075745f636f6e74656e7473282f637573746f6d2f64727570616c5f74657374322f64727570616c5f74657374322e6d6f64756c65293a206661696c656420746f206f70656e2073747265616d3a204e6f20737563682066696c65206f72206469726563746f7279223b733a393a222566756e6374696f6e223b733a33353a2266656174757265735f6578706f72745f6275696c645f666f726d5f7375626d69742829223b733a353a222566696c65223b733a3130363a222f7661722f7777772f6469676974616c73747566662e6465762f7075626c69635f68746d6c2f44727570616c546573742f7765622f73697465732f616c6c2f6d6f64756c65732f636f6e747269622f66656174757265732f66656174757265732e61646d696e2e696e63223b733a353a22256c696e65223b693a313034383b733a31343a2273657665726974795f6c6576656c223b693a343b7d, 4, '', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/create', '212.200.181.117', 1608041488),
(244, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'http://default/', '', '127.0.0.1', 1608041713),
(245, 1, 'content', '@type: updated %title.', 0x613a323a7b733a353a224074797065223b733a333a226a6f62223b733a363a22257469746c65223b733a31333a2254657374696e67206a6f622032223b7d, 5, '<a href=\"/DrupalTest/web/node/3\">view</a>', 'https://digitalstuff.dev/DrupalTest/web/node/3/edit', 'https://digitalstuff.dev/DrupalTest/web/node/3/edit', '212.200.181.117', 1608041774),
(246, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/reports/status/run-cron?destination=admin/modules', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.181.117', 1608041891),
(247, 1, 'page not found', 'admin/structure/features/drupal_test2', 0x4e3b, 4, '', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/drupal_test2', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features', '212.200.181.117', 1608041944),
(248, 1, 'page not found', 'admin/structure/features/drupal_test2/recreate', 0x4e3b, 4, '', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features/drupal_test2/recreate', 'https://digitalstuff.dev/DrupalTest/web/admin/structure/features', '212.200.181.117', 1608041950),
(249, 1, 'user', 'Session closed for %name.', 0x613a313a7b733a353a22256e616d65223b733a373a22767261646f7661223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/user/logout', 'https://digitalstuff.dev/DrupalTest/web/', '212.200.181.117', 1608042363),
(250, 1, 'user', 'Session opened for %name.', 0x613a313a7b733a353a22256e616d65223b733a373a22767261646f7661223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/user', 'https://digitalstuff.dev/DrupalTest/web/user', '178.223.112.184', 1608051220),
(251, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', 'https://digitalstuff.dev/DrupalTest/web/node/4', '178.223.112.184', 1608057605),
(252, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/', '', '212.200.65.95', 1608104957),
(253, 1, 'user', 'Session opened for %name.', 0x613a313a7b733a353a22256e616d65223b733a373a22767261646f7661223b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/node?destination=node', 'https://digitalstuff.dev/DrupalTest/web/', '212.200.65.95', 1608104967),
(254, 1, 'system', '%module module disabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31313a2264727570616c5f74657374223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.65.95', 1608105013),
(255, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/reports/status/run-cron?destination=admin/modules', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.65.95', 1608105018),
(256, 1, 'system', '%module module enabled.', 0x613a313a7b733a373a22256d6f64756c65223b733a31313a2264727570616c5f74657374223b7d, 6, '', 'https://digitalstuff.dev/DrupalTest/web/admin/modules/list/confirm', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.65.95', 1608106221),
(257, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'https://digitalstuff.dev/DrupalTest/web/admin/reports/status/run-cron?destination=admin/modules', 'https://digitalstuff.dev/DrupalTest/web/admin/modules', '212.200.65.95', 1608106224),
(258, 0, 'cron', 'Cron run completed.', 0x613a303a7b7d, 5, '', 'http://default/', '', '127.0.0.1', 1608106270);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jbqo_actions`
--
ALTER TABLE `jbqo_actions`
  ADD PRIMARY KEY (`aid`);

--
-- Indexes for table `jbqo_authmap`
--
ALTER TABLE `jbqo_authmap`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `authname` (`authname`),
  ADD KEY `uid_module` (`uid`,`module`);

--
-- Indexes for table `jbqo_batch`
--
ALTER TABLE `jbqo_batch`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `jbqo_block`
--
ALTER TABLE `jbqo_block`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  ADD KEY `list` (`theme`,`status`,`region`,`weight`,`module`);

--
-- Indexes for table `jbqo_blocked_ips`
--
ALTER TABLE `jbqo_blocked_ips`
  ADD PRIMARY KEY (`iid`),
  ADD KEY `blocked_ip` (`ip`);

--
-- Indexes for table `jbqo_block_custom`
--
ALTER TABLE `jbqo_block_custom`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `info` (`info`);

--
-- Indexes for table `jbqo_block_node_type`
--
ALTER TABLE `jbqo_block_node_type`
  ADD PRIMARY KEY (`module`,`delta`,`type`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `jbqo_block_role`
--
ALTER TABLE `jbqo_block_role`
  ADD PRIMARY KEY (`module`,`delta`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `jbqo_cache`
--
ALTER TABLE `jbqo_cache`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_block`
--
ALTER TABLE `jbqo_cache_block`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_bootstrap`
--
ALTER TABLE `jbqo_cache_bootstrap`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_features`
--
ALTER TABLE `jbqo_cache_features`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_field`
--
ALTER TABLE `jbqo_cache_field`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_filter`
--
ALTER TABLE `jbqo_cache_filter`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_form`
--
ALTER TABLE `jbqo_cache_form`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_image`
--
ALTER TABLE `jbqo_cache_image`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_menu`
--
ALTER TABLE `jbqo_cache_menu`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_page`
--
ALTER TABLE `jbqo_cache_page`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_path`
--
ALTER TABLE `jbqo_cache_path`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_update`
--
ALTER TABLE `jbqo_cache_update`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_views`
--
ALTER TABLE `jbqo_cache_views`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_cache_views_data`
--
ALTER TABLE `jbqo_cache_views_data`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_comment`
--
ALTER TABLE `jbqo_comment`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `comment_status_pid` (`pid`,`status`),
  ADD KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  ADD KEY `comment_uid` (`uid`),
  ADD KEY `comment_nid_language` (`nid`,`language`),
  ADD KEY `comment_created` (`created`);

--
-- Indexes for table `jbqo_ctools_css_cache`
--
ALTER TABLE `jbqo_ctools_css_cache`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `jbqo_ctools_object_cache`
--
ALTER TABLE `jbqo_ctools_object_cache`
  ADD PRIMARY KEY (`sid`,`obj`,`name`),
  ADD KEY `updated` (`updated`);

--
-- Indexes for table `jbqo_date_formats`
--
ALTER TABLE `jbqo_date_formats`
  ADD PRIMARY KEY (`dfid`),
  ADD UNIQUE KEY `formats` (`format`,`type`);

--
-- Indexes for table `jbqo_date_format_locale`
--
ALTER TABLE `jbqo_date_format_locale`
  ADD PRIMARY KEY (`type`,`language`);

--
-- Indexes for table `jbqo_date_format_type`
--
ALTER TABLE `jbqo_date_format_type`
  ADD PRIMARY KEY (`type`),
  ADD KEY `title` (`title`);

--
-- Indexes for table `jbqo_features_signature`
--
ALTER TABLE `jbqo_features_signature`
  ADD PRIMARY KEY (`module`,`component`),
  ADD KEY `module` (`module`),
  ADD KEY `component` (`component`);

--
-- Indexes for table `jbqo_field_config`
--
ALTER TABLE `jbqo_field_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_name` (`field_name`),
  ADD KEY `active` (`active`),
  ADD KEY `storage_active` (`storage_active`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `module` (`module`),
  ADD KEY `storage_module` (`storage_module`),
  ADD KEY `type` (`type`),
  ADD KEY `storage_type` (`storage_type`);

--
-- Indexes for table `jbqo_field_config_instance`
--
ALTER TABLE `jbqo_field_config_instance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  ADD KEY `deleted` (`deleted`);

--
-- Indexes for table `jbqo_field_data_body`
--
ALTER TABLE `jbqo_field_data_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `body_format` (`body_format`);

--
-- Indexes for table `jbqo_field_data_comment_body`
--
ALTER TABLE `jbqo_field_data_comment_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `comment_body_format` (`comment_body_format`);

--
-- Indexes for table `jbqo_field_data_field_employment_type`
--
ALTER TABLE `jbqo_field_data_field_employment_type`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_employment_type_value` (`field_employment_type_value`);

--
-- Indexes for table `jbqo_field_data_field_image`
--
ALTER TABLE `jbqo_field_data_field_image`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_image_fid` (`field_image_fid`);

--
-- Indexes for table `jbqo_field_data_field_tags`
--
ALTER TABLE `jbqo_field_data_field_tags`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_tags_tid` (`field_tags_tid`);

--
-- Indexes for table `jbqo_field_revision_body`
--
ALTER TABLE `jbqo_field_revision_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `body_format` (`body_format`);

--
-- Indexes for table `jbqo_field_revision_comment_body`
--
ALTER TABLE `jbqo_field_revision_comment_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `comment_body_format` (`comment_body_format`);

--
-- Indexes for table `jbqo_field_revision_field_employment_type`
--
ALTER TABLE `jbqo_field_revision_field_employment_type`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_employment_type_value` (`field_employment_type_value`);

--
-- Indexes for table `jbqo_field_revision_field_image`
--
ALTER TABLE `jbqo_field_revision_field_image`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_image_fid` (`field_image_fid`);

--
-- Indexes for table `jbqo_field_revision_field_tags`
--
ALTER TABLE `jbqo_field_revision_field_tags`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_tags_tid` (`field_tags_tid`);

--
-- Indexes for table `jbqo_file_managed`
--
ALTER TABLE `jbqo_file_managed`
  ADD PRIMARY KEY (`fid`),
  ADD UNIQUE KEY `uri` (`uri`),
  ADD KEY `uid` (`uid`),
  ADD KEY `status` (`status`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `jbqo_file_usage`
--
ALTER TABLE `jbqo_file_usage`
  ADD PRIMARY KEY (`fid`,`type`,`id`,`module`),
  ADD KEY `type_id` (`type`,`id`),
  ADD KEY `fid_count` (`fid`,`count`),
  ADD KEY `fid_module` (`fid`,`module`);

--
-- Indexes for table `jbqo_filter`
--
ALTER TABLE `jbqo_filter`
  ADD PRIMARY KEY (`format`,`name`),
  ADD KEY `list` (`weight`,`module`,`name`);

--
-- Indexes for table `jbqo_filter_format`
--
ALTER TABLE `jbqo_filter_format`
  ADD PRIMARY KEY (`format`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `status_weight` (`status`,`weight`);

--
-- Indexes for table `jbqo_flood`
--
ALTER TABLE `jbqo_flood`
  ADD PRIMARY KEY (`fid`),
  ADD KEY `allow` (`event`,`identifier`,`timestamp`),
  ADD KEY `purge` (`expiration`);

--
-- Indexes for table `jbqo_history`
--
ALTER TABLE `jbqo_history`
  ADD PRIMARY KEY (`uid`,`nid`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `jbqo_image_effects`
--
ALTER TABLE `jbqo_image_effects`
  ADD PRIMARY KEY (`ieid`),
  ADD KEY `isid` (`isid`),
  ADD KEY `weight` (`weight`);

--
-- Indexes for table `jbqo_image_styles`
--
ALTER TABLE `jbqo_image_styles`
  ADD PRIMARY KEY (`isid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `jbqo_menu_custom`
--
ALTER TABLE `jbqo_menu_custom`
  ADD PRIMARY KEY (`menu_name`);

--
-- Indexes for table `jbqo_menu_links`
--
ALTER TABLE `jbqo_menu_links`
  ADD PRIMARY KEY (`mlid`),
  ADD KEY `path_menu` (`link_path`(128),`menu_name`),
  ADD KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  ADD KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  ADD KEY `router_path` (`router_path`(128));

--
-- Indexes for table `jbqo_menu_router`
--
ALTER TABLE `jbqo_menu_router`
  ADD PRIMARY KEY (`path`),
  ADD KEY `fit` (`fit`),
  ADD KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  ADD KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`);

--
-- Indexes for table `jbqo_node`
--
ALTER TABLE `jbqo_node`
  ADD PRIMARY KEY (`nid`),
  ADD UNIQUE KEY `vid` (`vid`),
  ADD KEY `node_changed` (`changed`),
  ADD KEY `node_created` (`created`),
  ADD KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  ADD KEY `node_status_type` (`status`,`type`,`nid`),
  ADD KEY `node_title_type` (`title`,`type`(4)),
  ADD KEY `node_type` (`type`(4)),
  ADD KEY `uid` (`uid`),
  ADD KEY `tnid` (`tnid`),
  ADD KEY `translate` (`translate`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `jbqo_node_access`
--
ALTER TABLE `jbqo_node_access`
  ADD PRIMARY KEY (`nid`,`gid`,`realm`);

--
-- Indexes for table `jbqo_node_comment_statistics`
--
ALTER TABLE `jbqo_node_comment_statistics`
  ADD PRIMARY KEY (`nid`),
  ADD KEY `node_comment_timestamp` (`last_comment_timestamp`),
  ADD KEY `comment_count` (`comment_count`),
  ADD KEY `last_comment_uid` (`last_comment_uid`);

--
-- Indexes for table `jbqo_node_revision`
--
ALTER TABLE `jbqo_node_revision`
  ADD PRIMARY KEY (`vid`),
  ADD KEY `nid` (`nid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `jbqo_node_type`
--
ALTER TABLE `jbqo_node_type`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `jbqo_queue`
--
ALTER TABLE `jbqo_queue`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `name_created` (`name`,`created`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_rdf_mapping`
--
ALTER TABLE `jbqo_rdf_mapping`
  ADD PRIMARY KEY (`type`,`bundle`);

--
-- Indexes for table `jbqo_registry`
--
ALTER TABLE `jbqo_registry`
  ADD PRIMARY KEY (`name`,`type`),
  ADD KEY `hook` (`type`,`weight`,`module`);

--
-- Indexes for table `jbqo_registry_file`
--
ALTER TABLE `jbqo_registry_file`
  ADD PRIMARY KEY (`filename`);

--
-- Indexes for table `jbqo_role`
--
ALTER TABLE `jbqo_role`
  ADD PRIMARY KEY (`rid`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `name_weight` (`name`,`weight`);

--
-- Indexes for table `jbqo_role_permission`
--
ALTER TABLE `jbqo_role_permission`
  ADD PRIMARY KEY (`rid`,`permission`),
  ADD KEY `permission` (`permission`);

--
-- Indexes for table `jbqo_search_dataset`
--
ALTER TABLE `jbqo_search_dataset`
  ADD PRIMARY KEY (`sid`,`type`);

--
-- Indexes for table `jbqo_search_index`
--
ALTER TABLE `jbqo_search_index`
  ADD PRIMARY KEY (`word`,`sid`,`type`),
  ADD KEY `sid_type` (`sid`,`type`);

--
-- Indexes for table `jbqo_search_node_links`
--
ALTER TABLE `jbqo_search_node_links`
  ADD PRIMARY KEY (`sid`,`type`,`nid`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `jbqo_search_total`
--
ALTER TABLE `jbqo_search_total`
  ADD PRIMARY KEY (`word`);

--
-- Indexes for table `jbqo_semaphore`
--
ALTER TABLE `jbqo_semaphore`
  ADD PRIMARY KEY (`name`),
  ADD KEY `value` (`value`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `jbqo_sequences`
--
ALTER TABLE `jbqo_sequences`
  ADD PRIMARY KEY (`value`);

--
-- Indexes for table `jbqo_sessions`
--
ALTER TABLE `jbqo_sessions`
  ADD PRIMARY KEY (`sid`,`ssid`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `uid` (`uid`),
  ADD KEY `ssid` (`ssid`);

--
-- Indexes for table `jbqo_shortcut_set`
--
ALTER TABLE `jbqo_shortcut_set`
  ADD PRIMARY KEY (`set_name`);

--
-- Indexes for table `jbqo_shortcut_set_users`
--
ALTER TABLE `jbqo_shortcut_set_users`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `set_name` (`set_name`);

--
-- Indexes for table `jbqo_system`
--
ALTER TABLE `jbqo_system`
  ADD PRIMARY KEY (`filename`),
  ADD KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  ADD KEY `type_name` (`type`,`name`);

--
-- Indexes for table `jbqo_taxonomy_index`
--
ALTER TABLE `jbqo_taxonomy_index`
  ADD KEY `term_node` (`tid`,`sticky`,`created`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `jbqo_taxonomy_term_data`
--
ALTER TABLE `jbqo_taxonomy_term_data`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  ADD KEY `vid_name` (`vid`,`name`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `jbqo_taxonomy_term_hierarchy`
--
ALTER TABLE `jbqo_taxonomy_term_hierarchy`
  ADD PRIMARY KEY (`tid`,`parent`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `jbqo_taxonomy_vocabulary`
--
ALTER TABLE `jbqo_taxonomy_vocabulary`
  ADD PRIMARY KEY (`vid`),
  ADD UNIQUE KEY `machine_name` (`machine_name`),
  ADD KEY `list` (`weight`,`name`);

--
-- Indexes for table `jbqo_url_alias`
--
ALTER TABLE `jbqo_url_alias`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `alias_language_pid` (`alias`,`language`,`pid`),
  ADD KEY `source_language_pid` (`source`,`language`,`pid`);

--
-- Indexes for table `jbqo_users`
--
ALTER TABLE `jbqo_users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `access` (`access`),
  ADD KEY `created` (`created`),
  ADD KEY `mail` (`mail`),
  ADD KEY `picture` (`picture`);

--
-- Indexes for table `jbqo_users_roles`
--
ALTER TABLE `jbqo_users_roles`
  ADD PRIMARY KEY (`uid`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `jbqo_variable`
--
ALTER TABLE `jbqo_variable`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `jbqo_views_display`
--
ALTER TABLE `jbqo_views_display`
  ADD PRIMARY KEY (`vid`,`id`),
  ADD KEY `vid` (`vid`,`position`);

--
-- Indexes for table `jbqo_views_view`
--
ALTER TABLE `jbqo_views_view`
  ADD PRIMARY KEY (`vid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `jbqo_watchdog`
--
ALTER TABLE `jbqo_watchdog`
  ADD PRIMARY KEY (`wid`),
  ADD KEY `type` (`type`),
  ADD KEY `uid` (`uid`),
  ADD KEY `severity` (`severity`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jbqo_authmap`
--
ALTER TABLE `jbqo_authmap`
  MODIFY `aid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.';

--
-- AUTO_INCREMENT for table `jbqo_block`
--
ALTER TABLE `jbqo_block`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.', AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `jbqo_blocked_ips`
--
ALTER TABLE `jbqo_blocked_ips`
  MODIFY `iid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.';

--
-- AUTO_INCREMENT for table `jbqo_block_custom`
--
ALTER TABLE `jbqo_block_custom`
  MODIFY `bid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The block’s `jbqo_block`.bid.';

--
-- AUTO_INCREMENT for table `jbqo_comment`
--
ALTER TABLE `jbqo_comment`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.';

--
-- AUTO_INCREMENT for table `jbqo_date_formats`
--
ALTER TABLE `jbqo_date_formats`
  MODIFY `dfid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.', AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `jbqo_field_config`
--
ALTER TABLE `jbqo_field_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jbqo_field_config_instance`
--
ALTER TABLE `jbqo_field_config_instance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance', AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `jbqo_file_managed`
--
ALTER TABLE `jbqo_file_managed`
  MODIFY `fid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'File ID.';

--
-- AUTO_INCREMENT for table `jbqo_flood`
--
ALTER TABLE `jbqo_flood`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.';

--
-- AUTO_INCREMENT for table `jbqo_image_effects`
--
ALTER TABLE `jbqo_image_effects`
  MODIFY `ieid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.';

--
-- AUTO_INCREMENT for table `jbqo_image_styles`
--
ALTER TABLE `jbqo_image_styles`
  MODIFY `isid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.';

--
-- AUTO_INCREMENT for table `jbqo_menu_links`
--
ALTER TABLE `jbqo_menu_links`
  MODIFY `mlid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.', AUTO_INCREMENT=408;

--
-- AUTO_INCREMENT for table `jbqo_node`
--
ALTER TABLE `jbqo_node`
  MODIFY `nid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jbqo_node_revision`
--
ALTER TABLE `jbqo_node_revision`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jbqo_queue`
--
ALTER TABLE `jbqo_queue`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.', AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `jbqo_role`
--
ALTER TABLE `jbqo_role`
  MODIFY `rid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jbqo_sequences`
--
ALTER TABLE `jbqo_sequences`
  MODIFY `value` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jbqo_taxonomy_term_data`
--
ALTER TABLE `jbqo_taxonomy_term_data`
  MODIFY `tid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.';

--
-- AUTO_INCREMENT for table `jbqo_taxonomy_vocabulary`
--
ALTER TABLE `jbqo_taxonomy_vocabulary`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jbqo_url_alias`
--
ALTER TABLE `jbqo_url_alias`
  MODIFY `pid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.';

--
-- AUTO_INCREMENT for table `jbqo_views_view`
--
ALTER TABLE `jbqo_views_view`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The view ID of the field, defined by the database.', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jbqo_watchdog`
--
ALTER TABLE `jbqo_watchdog`
  MODIFY `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.', AUTO_INCREMENT=259;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
